module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        dao_count: u64,
        paused: bool,
        allowed_stable_types: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct FactoryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ValidatorAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerificationRequested has copy, drop {
        dao_id: 0x2::object::ID,
        verification_id: 0x2::object::ID,
        requester: address,
        attestation_url: 0x1::string::String,
        timestamp: u64,
    }

    struct DAOReviewed has copy, drop {
        dao_id: 0x2::object::ID,
        verification_id: 0x2::object::ID,
        attestation_url: 0x1::string::String,
        verified: bool,
        validator: address,
        timestamp: u64,
        reject_reason: 0x1::string::String,
    }

    struct StableCoinTypeAdded has copy, drop {
        type_str: 0x1::string::String,
        admin: address,
        timestamp: u64,
    }

    struct StableCoinTypeRemoved has copy, drop {
        type_str: 0x1::string::String,
        admin: address,
        timestamp: u64,
    }

    public entry fun add_allowed_stable_type<T0>(arg0: &mut Factory, arg1: &FactoryOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_type_string<T0>();
        if (!0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_stable_types, &v0)) {
            0x2::vec_set::insert<0x1::string::String>(&mut arg0.allowed_stable_types, v0);
            let v1 = StableCoinTypeAdded{
                type_str  : v0,
                admin     : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<StableCoinTypeAdded>(v1);
        };
    }

    public entry fun burn_factory_owner_cap(arg0: FactoryOwnerCap) {
        let FactoryOwnerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create_dao<T0, T1>(arg0: &mut Factory, arg1: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::FeeManager, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: u64, arg8: u64, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: u64, arg12: u64, arg13: u128, arg14: u64, arg15: 0x1::string::String, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = get_type_string<T1>();
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_stable_types, &v0), 4);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::deposit_dao_creation_payment(arg1, arg2, arg16, arg17);
        let v1 = 0x2::coin::get_icon_url<T0>(arg9);
        let v2 = if (0x1::option::is_none<0x2::url::Url>(&v1)) {
            0x1::ascii::string(b"")
        } else {
            0x2::url::inner_url(0x1::option::borrow<0x2::url::Url>(&v1))
        };
        let v3 = 0x2::coin::get_icon_url<T1>(arg10);
        let v4 = if (0x1::option::is_none<0x2::url::Url>(&v3)) {
            0x1::ascii::string(b"")
        } else {
            0x2::url::inner_url(0x1::option::borrow<0x2::url::Url>(&v3))
        };
        assert!(arg12 >= 1, 5);
        assert!(arg7 <= 604800000, 7);
        assert!(arg8 <= 604800000, 6);
        assert!(arg11 <= 86400000, 8);
        assert!(arg11 + 60000 < arg8, 10);
        assert!(arg14 <= 1000000, 0);
        assert!(arg13 <= 18446744073709551615000000000000, 9);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::create<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::get_decimals<T0>(arg9), 0x2::coin::get_decimals<T1>(arg10), 0x2::coin::get_name<T0>(arg9), 0x2::coin::get_name<T1>(arg10), v2, v4, 0x2::coin::get_symbol<T0>(arg9), 0x2::coin::get_symbol<T1>(arg10), arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        arg0.dao_count = arg0.dao_count + 1;
    }

    public fun dao_count(arg0: &Factory) : u64 {
        arg0.dao_count
    }

    public entry fun disable_dao_proposals(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::DAO, arg1: &FactoryOwnerCap) {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::disable_proposals(arg0);
    }

    fun get_type_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())))
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<FACTORY>(&arg0), 3);
        let v0 = Factory{
            id                   : 0x2::object::new(arg1),
            dao_count            : 0,
            paused               : false,
            allowed_stable_types : 0x2::vec_set::empty<0x1::string::String>(),
        };
        let v1 = FactoryOwnerCap{id: 0x2::object::new(arg1)};
        let v2 = ValidatorAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Factory>(v0);
        0x2::transfer::public_transfer<FactoryOwnerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ValidatorAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Factory) : bool {
        arg0.paused
    }

    public fun is_stable_type_allowed<T0>(arg0: &Factory) : bool {
        let v0 = get_type_string<T0>();
        0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_stable_types, &v0)
    }

    public entry fun remove_allowed_stable_type<T0>(arg0: &mut Factory, arg1: &FactoryOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_type_string<T0>();
        if (0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_stable_types, &v0)) {
            0x2::vec_set::remove<0x1::string::String>(&mut arg0.allowed_stable_types, &v0);
            let v1 = StableCoinTypeRemoved{
                type_str  : v0,
                admin     : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<StableCoinTypeRemoved>(v1);
        };
    }

    public entry fun request_verification(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::DAO, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::is_verified(arg2), 2);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee::deposit_verification_payment(arg0, arg1, arg4, arg5);
        let v0 = 0x2::object::new(arg5);
        0x2::object::delete(v0);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::set_pending_verification(arg2, arg3);
        let v1 = VerificationRequested{
            dao_id          : 0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::DAO>(arg2),
            verification_id : 0x2::object::uid_to_inner(&v0),
            requester       : 0x2::tx_context::sender(arg5),
            attestation_url : arg3,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VerificationRequested>(v1);
    }

    public entry fun toggle_pause(arg0: &mut Factory, arg1: &FactoryOwnerCap) {
        arg0.paused = !arg0.paused;
    }

    public entry fun verify_dao(arg0: &ValidatorAdminCap, arg1: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::DAO, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: bool, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::set_verification(arg1, arg3, arg4);
        let v0 = DAOReviewed{
            dao_id          : 0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::dao::DAO>(arg1),
            verification_id : arg2,
            attestation_url : arg3,
            verified        : arg4,
            validator       : 0x2::tx_context::sender(arg7),
            timestamp       : 0x2::clock::timestamp_ms(arg6),
            reject_reason   : arg5,
        };
        0x2::event::emit<DAOReviewed>(v0);
    }

    // decompiled from Move bytecode v6
}

