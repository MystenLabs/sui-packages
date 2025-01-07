module 0xd1392494c04e25c56b53a9afd880bd9d2d972c3f93c569f668f187225c54d8b4::wave_spin {
    struct App has key {
        id: 0x2::object::UID,
        spins: vector<Spin>,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct Spin has store {
        price: u64,
        start_time: u64,
        end_time: u64,
        coin_type: vector<u8>,
        max_buy_per_user: u64,
        nft_discount_rate: u16,
        total_sell: u64,
        sold: u64,
        enable: bool,
    }

    struct TicketBought has copy, drop, store {
        receiver: address,
        spin_id: u64,
        price: u64,
        amount: u64,
        coin_type: 0x1::string::String,
    }

    struct TokenClaimed has copy, drop, store {
        receiver: address,
        coin_type: 0x1::string::String,
        id: u64,
        amount: u64,
    }

    struct NftClaimed has copy, drop, store {
        receiver: address,
        id: u64,
    }

    struct BoostClaimed has copy, drop, store {
        receiver: address,
        id: u64,
        level: u8,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_deposit<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: 0x2::coin::Coin<T0>) {
        let v0 = type_to_bytes<T0>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), 0x2::coin::into_balance<T0>(arg2));
    }

    entry fun admin_withdraw<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = type_to_bytes<T0>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            abort 14
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun authorize_game(arg0: &0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::OwnerCap, arg1: &mut App) {
        0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::authorize_app(arg0, &mut arg1.id);
    }

    public fun authorize_nft(arg0: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NftOwnerCap, arg1: &mut App) {
        0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    entry fun buy_ticket<T0>(arg0: &mut App, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        inner_buy_ticket<T0>(arg0, v0, false, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun buy_ticket_discount<T0>(arg0: &mut App, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        inner_buy_ticket<T0>(arg0, v0, true, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
    }

    entry fun claim_boost(arg0: &mut App, arg1: &mut 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::GameInfo, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 9);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::string::utf8(b"WAVE_SPIN_CLAIM_BOOST:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v2) == true, 6);
        let v4 = 0x1::string::utf8(b"SPIN_CLAIM:");
        let v5 = 0x2::bcs::to_bytes<0x1::string::String>(&v4);
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v5), 15);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v5, true);
        let v6 = BoostClaimed{
            receiver : v0,
            id       : arg2,
            level    : 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::auth_upgrade_seafood(&mut arg0.id, arg1, 1, v0),
        };
        0x2::event::emit<BoostClaimed>(v6);
    }

    entry fun claim_nft(arg0: &mut App, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 9);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::string::utf8(b"WAVE_SPIN_CLAIM_NFT:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg1));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg4));
        let v7 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v7));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u16>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.operator_pk, &v2) == true, 6);
        let v8 = 0x1::string::utf8(b"SPIN_CLAIM:");
        let v9 = 0x2::bcs::to_bytes<0x1::string::String>(&v8);
        0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v9), 15);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v9, true);
        0x2::transfer::public_transfer<0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT>(0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::mint(&mut arg0.id, arg2, arg3, arg4, arg5, arg7), v0);
        let v10 = NftClaimed{
            receiver : v0,
            id       : arg1,
        };
        0x2::event::emit<NftClaimed>(v10);
    }

    entry fun claim_token<T0>(arg0: &mut App, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 9);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = type_to_bytes<T0>();
        let v2 = 0x1::string::utf8(b"WAVE_SPIN_CLAIM_TOKEN:");
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(&v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v3, v1);
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v3) == true, 6);
        let v7 = 0x1::string::utf8(b"SPIN_CLAIM:");
        let v8 = 0x2::bcs::to_bytes<0x1::string::String>(&v7);
        0x1::vector::append<u8>(&mut v8, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v8), 15);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v8, true);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            abort 14
        };
        let v9 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v9) >= arg2, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, arg2), arg4), v0);
        let v10 = TokenClaimed{
            receiver  : v0,
            coin_type : 0x1::string::utf8(v1),
            id        : arg1,
            amount    : arg2,
        };
        0x2::event::emit<TokenClaimed>(v10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            spins       : 0x1::vector::empty<Spin>(),
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            version     : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun inner_buy_ticket<T0>(arg0: &mut App, arg1: address, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 9);
        validate_signature(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        assert!(arg4 < 0x1::vector::length<Spin>(&arg0.spins), 3);
        let v0 = 0x1::vector::borrow_mut<Spin>(&mut arg0.spins, arg4);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0.start_time == 0 || v1 >= v0.start_time, 10);
        assert!(v0.end_time == 0 || v1 <= v0.end_time, 11);
        let v2 = type_to_bytes<T0>();
        assert!(0xd1392494c04e25c56b53a9afd880bd9d2d972c3f93c569f668f187225c54d8b4::compare::cmp_bcs_bytes(&v0.coin_type, &v2) == 0, 1);
        assert!(v0.enable == true, 12);
        assert!(v0.total_sell == 0 || v0.sold + arg5 <= v0.total_sell, 13);
        let v3 = 0x2::bcs::to_bytes<address>(&arg1);
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg4));
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v3)) {
            assert!(v0.max_buy_per_user == 0 || arg5 <= v0.max_buy_per_user, 4);
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v3, arg5);
        } else {
            let v5 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v3);
            assert!(v0.max_buy_per_user == 0 || *v5 + arg5 <= v0.max_buy_per_user, 4);
            *v5 = *v5 + arg5;
        };
        v0.sold = v0.sold + arg5;
        let v6 = v0.price * arg5;
        let v7 = v6;
        if (arg2) {
            v7 = v6 * (10000 - (v0.nft_discount_rate as u64)) / 10000;
        };
        assert!(0x2::coin::value<T0>(&arg3) >= v7, 2);
        0x2::pay::keep<T0>(arg3, arg9);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v7, arg9)));
        let v8 = TicketBought{
            receiver  : arg1,
            spin_id   : arg4,
            price     : v0.price,
            amount    : arg5,
            coin_type : 0x1::string::utf8(v2),
        };
        0x2::event::emit<TicketBought>(v8);
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    fun type_to_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    entry fun update_operator(arg0: &OwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    entry fun upsert_spin<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u16, arg7: u64, arg8: u64, arg9: bool) {
        if (arg2 < 0x1::vector::length<Spin>(&arg1.spins)) {
            let v0 = 0x1::vector::borrow_mut<Spin>(&mut arg1.spins, arg2);
            v0.start_time = arg3;
            v0.end_time = arg4;
            v0.price = arg5;
            v0.nft_discount_rate = arg6;
            v0.max_buy_per_user = arg7;
            v0.total_sell = arg8;
            v0.enable = arg9;
            v0.coin_type = type_to_bytes<T0>();
        } else {
            let v1 = Spin{
                price             : arg5,
                start_time        : arg3,
                end_time          : arg4,
                coin_type         : type_to_bytes<T0>(),
                max_buy_per_user  : arg7,
                nft_discount_rate : arg6,
                total_sell        : arg8,
                sold              : 0,
                enable            : arg9,
            };
            0x1::vector::push_back<Spin>(&mut arg1.spins, v1);
        };
    }

    fun validate_signature(arg0: &App, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_SPIN_BUY_TICKET:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.operator_pk, &v1) == true, 6);
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 7);
    }

    // decompiled from Move bytecode v6
}

