module 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        manager: address,
        protocol_fee: u64,
        supported_coin_types: vector<0x1::ascii::String>,
        executed_quotes: 0x2::table::Table<0x1::string::String, bool>,
        sequence_number: u128,
    }

    struct Quote has copy, drop {
        vault: 0x2::object::ID,
        id: 0x1::string::String,
        taker: address,
        token_in_amount: u64,
        token_out_amount: u64,
        token_in_type: 0x1::string::String,
        token_out_type: 0x1::string::String,
        expires_at: u64,
        created_at: u64,
    }

    struct SupportedToken<phantom T0> has store {
        swaps: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
        min_deposit: u64,
    }

    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Vault, arg2: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg2);
        let v0 = bytes_to_quote(arg3);
        validate_signature(arg1.manager, v0, arg4);
        internal_swap<T0, T1>(arg0, arg1, v0, arg5, arg6)
    }

    fun bytes_to_quote(arg0: vector<u8>) : Quote {
        let v0 = 0x2::bcs::new(arg0);
        Quote{
            vault            : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            id               : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            taker            : 0x2::bcs::peel_address(&mut v0),
            token_in_amount  : 0x2::bcs::peel_u64(&mut v0),
            token_out_amount : 0x2::bcs::peel_u64(&mut v0),
            token_in_type    : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            token_out_type   : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            expires_at       : 0x2::bcs::peel_u64(&mut v0),
            created_at       : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun claim_protocol_fee<T0>(arg0: &mut Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg1);
        let v0 = get_accrued_protocol_fee<T0>(arg0);
        assert!(v0 > 0, 1020);
        get_coin_type<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 1011);
        let v1 = 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::protocol_fee_recipient(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SupportedToken<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).fee), arg2), v1);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_protocol_fee_claimed_event(0x2::object::uid_to_inner(&arg0.id), get_coin_type<T0>(), v0, v1, arg0.sequence_number);
    }

    public fun create_rfq_vault(arg0: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg0);
        assert!(arg1 != @0x0, 1004);
        let v0 = 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::protocol_fee(arg0);
        let v1 = Vault{
            id                   : 0x2::object::new(arg2),
            manager              : arg1,
            protocol_fee         : v0,
            supported_coin_types : 0x1::vector::empty<0x1::ascii::String>(),
            executed_quotes      : 0x2::table::new<0x1::string::String, bool>(arg2),
            sequence_number      : 0,
        };
        0x2::transfer::share_object<Vault>(v1);
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_vault_created_event(0x2::object::uid_to_inner(&v1.id), 0x2::tx_context::sender(arg2), arg1, v0);
    }

    fun deduct_protocol_fee<T0>(arg0: &mut Vault, arg1: &mut 0x2::balance::Balance<T0>) : u64 {
        let v0 = ((((0x2::balance::value<T0>(arg1) as u128) * (arg0.protocol_fee as u128) + (0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::protocol_fee_denominator() as u128) - 1) / (0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::protocol_fee_denominator() as u128)) as u64);
        let (_, _) = internal_deposit<T0>(arg0, 0x2::balance::split<T0>(arg1, v0), true);
        v0
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg1);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 1011);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 >= 0x2::dynamic_field::borrow<0x1::type_name::TypeName, SupportedToken<T0>>(&arg0.id, 0x1::type_name::get<T0>()).min_deposit, 1023);
        let (_, v2) = internal_deposit<T0>(arg0, arg2, false);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_coin_deposited_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), get_coin_type<T0>(), v0, v2, arg0.sequence_number);
    }

    public fun get_accrued_protocol_fee<T0>(arg0: &Vault) : u64 {
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, SupportedToken<T0>>(&arg0.id, 0x1::type_name::get<T0>()).fee)
        } else {
            0
        }
    }

    public fun get_coin_type<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun internal_deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: bool) : (u64, u64) {
        let v0 = if (arg2) {
            &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SupportedToken<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).fee
        } else {
            &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SupportedToken<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).swaps
        };
        0x2::balance::join<T0>(v0, arg1);
        (0x2::balance::value<T0>(v0), 0x2::balance::value<T0>(v0))
    }

    fun internal_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Vault, arg2: Quote, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(v0 == arg2.vault, 1016);
        assert!(0x2::clock::timestamp_ms(arg0) < arg2.expires_at, 1013);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.executed_quotes, arg2.id), 1014);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.executed_quotes, arg2.id, true);
        assert!(arg2.expires_at - arg2.created_at <= 2592000000, 1015);
        assert!(0x2::tx_context::sender(arg4) == arg2.taker, 1006);
        let v1 = get_coin_type<T0>();
        let v2 = get_coin_type<T1>();
        assert!(v1 == 0x1::string::to_ascii(arg2.token_in_type), 1009);
        assert!(v2 == 0x1::string::to_ascii(arg2.token_out_type), 1010);
        assert!(is_coin_supported(arg1, v1) && is_coin_supported(arg1, v2), 1011);
        assert!(0x2::balance::value<T0>(&arg3) == arg2.token_in_amount, 1012);
        let (v3, v4) = internal_deposit<T0>(arg1, arg3, false);
        let (v5, v6, v7) = internal_withdraw<T1>(arg1, arg2.token_out_amount);
        let v8 = v7;
        let v9 = &mut v8;
        let v10 = deduct_protocol_fee<T1>(arg1, v9);
        arg1.sequence_number = arg1.sequence_number + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_swap_executed_event(v0, arg2.id, arg2.taker, arg2.token_in_type, arg2.token_out_type, arg2.token_in_amount, arg2.token_out_amount, v10, v3, v5, v4, v6, arg1.sequence_number);
        v8
    }

    fun internal_withdraw<T0>(arg0: &mut Vault, arg1: u64) : (u64, u64, 0x2::balance::Balance<T0>) {
        let v0 = &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SupportedToken<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).swaps;
        (0x2::balance::value<T0>(v0), 0x2::balance::value<T0>(v0), 0x2::balance::split<T0>(v0, arg1))
    }

    public fun is_coin_supported(arg0: &Vault, arg1: 0x1::ascii::String) : bool {
        let (v0, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.supported_coin_types, &arg1);
        v0
    }

    public fun manager(arg0: &Vault) : address {
        arg0.manager
    }

    public fun quote_lifespan() : u64 {
        2592000000
    }

    public fun set_manager(arg0: &mut Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg1);
        assert!(arg0.manager == 0x2::tx_context::sender(arg3), 1006);
        assert!(arg0.manager != arg2, 1005);
        assert!(arg2 != @0x0, 1004);
        arg0.manager = arg2;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_vault_manager_updated_event(0x2::object::uid_to_inner(&arg0.id), arg0.manager, arg2);
    }

    public fun support_coin<T0>(arg0: &mut Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg1);
        assert!(arg0.manager == 0x2::tx_context::sender(arg3), 1006);
        assert!(arg2 > 0, 1008);
        let v0 = get_coin_type<T0>();
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 1022);
        let v1 = SupportedToken<T0>{
            swaps       : 0x2::balance::zero<T0>(),
            fee         : 0x2::balance::zero<T0>(),
            min_deposit : arg2,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, SupportedToken<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v1);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.supported_coin_types, v0);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_coin_supported(0x2::object::uid_to_inner(&arg0.id), v0, arg2, arg0.sequence_number);
    }

    public fun supported_coin_types(arg0: &Vault) : vector<0x1::ascii::String> {
        arg0.supported_coin_types
    }

    public fun total_coin_balance_amount<T0>(arg0: &Vault) : u64 {
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, SupportedToken<T0>>(&arg0.id, 0x1::type_name::get<T0>()).swaps)
    }

    public fun update_min_deposit<T0>(arg0: &mut Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg1);
        assert!(arg0.manager == 0x2::tx_context::sender(arg3), 1006);
        assert!(arg2 > 0, 1008);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 1011);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, SupportedToken<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        v0.min_deposit = arg2;
        arg0.sequence_number = arg0.sequence_number + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_min_deposit_coin_updated(0x2::object::uid_to_inner(&arg0.id), get_coin_type<T0>(), v0.min_deposit, arg2, arg0.sequence_number);
    }

    public fun validate_signature(arg0: address, arg1: Quote, arg2: vector<u8>) {
        let v0 = verify_signature(0x2::bcs::to_bytes<Quote>(&arg1), arg2);
        assert!(arg0 == 0x2::address::from_bytes(0x2::hash::blake2b256(&v0)), 1019);
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 97 || 0x1::vector::length<u8>(&arg1) == 98, 1021);
        let v0 = 0x1::vector::remove<u8>(&mut arg1, 0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg1, v3));
            v3 = v3 + 1;
        };
        while (v3 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg1, v3));
            v3 = v3 + 1;
        };
        let v4 = if (v0 == 0) {
            0x1::vector::insert<u8>(&mut v2, 0, 0);
            0x2::ed25519::ed25519_verify(&v1, &v2, &arg0)
        } else {
            assert!(v0 == 1, 1017);
            0x1::vector::insert<u8>(&mut v2, 1, 0);
            0x2::ecdsa_k1::secp256k1_verify(&v1, &v2, &arg0, 1)
        };
        assert!(v4, 1018);
        v2
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config::verify_supported_package(arg1);
        assert!(arg2 > 0, 1008);
        assert!(arg0.manager == 0x2::tx_context::sender(arg3), 1006);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>()), 1011);
        let (_, v1, v2) = internal_withdraw<T0>(arg0, arg2);
        arg0.sequence_number = arg0.sequence_number + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_coin_withdrawn_event(0x2::object::uid_to_inner(&arg0.id), get_coin_type<T0>(), arg2, v1, arg0.sequence_number);
        v2
    }

    // decompiled from Move bytecode v6
}

