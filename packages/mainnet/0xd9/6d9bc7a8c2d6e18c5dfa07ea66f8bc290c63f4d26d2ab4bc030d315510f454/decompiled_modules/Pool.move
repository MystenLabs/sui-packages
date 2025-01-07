module 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Pool {
    struct CreatePoolEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        owner: address,
        pool_id: 0x2::object::ID,
        spot_price: u64,
        coins: u64,
        token_ids: vector<0x2::object::ID>,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
        transactions: u64,
        total_transaction_value: u128,
        lp_fee_earnings: u64,
    }

    struct SwapEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        spot_price: u64,
        curve: u8,
        delta: u64,
        coins: u64,
        lp_fee_multiplier: u64,
        token_id: 0x2::object::ID,
        coin_amount: u64,
        protocol_fee: u64,
        protocol_payee: address,
        royalty_fee: u64,
        royalty_payee: address,
        lp_fee: u64,
        type: 0x1::string::String,
    }

    struct WithdrawCoinPoolEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        sender: address,
        to: address,
        pool_id: 0x2::object::ID,
        withdraw_coin_amount: u64,
        coins: u64,
        spot_price: u64,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
    }

    struct WithdrawTokenPoolEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        sender: address,
        to: address,
        pool_id: 0x2::object::ID,
        token_id: 0x2::object::ID,
        coins: u64,
        spot_price: u64,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
    }

    struct DepositTokenPoolEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        token_id: 0x2::object::ID,
        coins: u64,
        spot_price: u64,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
    }

    struct DepositCoinPoolEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        deposit_coin_amount: u64,
        coins: u64,
        spot_price: u64,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
    }

    struct EditPoolEvent<phantom T0: store + key, phantom T1> has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        spot_price: u64,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
    }

    struct Pool<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        spot_price: u64,
        coins: 0x2::coin::Coin<T1>,
        tokens: 0x2::object_table::ObjectTable<0x2::object::ID, T0>,
        token_ids: vector<0x2::object::ID>,
        curve: u8,
        delta: u64,
        lp_fee_multiplier: u64,
        transactions: u64,
        total_transaction_value: u128,
        lp_fee_earnings: u64,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    public entry fun Create<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: vector<T0>, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(arg3 == 1 || arg3 == 2, 231);
        assert!(0x2::coin::value<T1>(arg7) >= arg2, 10);
        let v3 = 0x2::object_table::new<0x2::object::ID, T0>(arg8);
        let v4 = 0;
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        while (v4 < 0x1::vector::length<T0>(&arg1)) {
            let v6 = 0x1::vector::pop_back<T0>(&mut arg1);
            0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<T0>(&v6));
            0x2::object_table::add<0x2::object::ID, T0>(&mut v3, 0x2::object::id<T0>(&v6), v6);
            v4 = v4 + 1;
        };
        let v7 = Pool<T0, T1>{
            id                      : 0x2::object::new(arg8),
            owner                   : v0,
            spot_price              : arg4,
            coins                   : 0x2::coin::split<T1>(arg7, arg2, arg8),
            tokens                  : v3,
            token_ids               : v5,
            curve                   : arg3,
            delta                   : arg5,
            lp_fee_multiplier       : arg6,
            transactions            : 0,
            total_transaction_value : 0,
            lp_fee_earnings         : 0,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v7);
        0x1::vector::destroy_empty<T0>(arg1);
        let v8 = CreatePoolEvent<T0, T1>{
            owner                   : v0,
            pool_id                 : 0x2::object::id<Pool<T0, T1>>(&v7),
            spot_price              : arg4,
            coins                   : arg2,
            token_ids               : v5,
            curve                   : arg3,
            delta                   : arg5,
            lp_fee_multiplier       : arg6,
            transactions            : 0,
            total_transaction_value : 0,
            lp_fee_earnings         : 0,
        };
        0x2::event::emit<CreatePoolEvent<T0, T1>>(v8);
    }

    public entry fun DepositCoin<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(v0 == arg1.owner, 3242);
        assert!(0x2::coin::value<T1>(arg3) >= arg2, 531);
        0x2::coin::join<T1>(&mut arg1.coins, 0x2::coin::split<T1>(arg3, arg2, arg4));
        let v3 = DepositCoinPoolEvent<T0, T1>{
            sender              : v0,
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg1),
            deposit_coin_amount : arg2,
            coins               : 0x2::coin::value<T1>(&arg1.coins),
            spot_price          : arg1.spot_price,
            curve               : arg1.curve,
            delta               : arg1.delta,
            lp_fee_multiplier   : arg1.lp_fee_multiplier,
        };
        0x2::event::emit<DepositCoinPoolEvent<T0, T1>>(v3);
    }

    public entry fun DepositToken<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Pool<T0, T1>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(v0 == arg1.owner, 3242);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.token_ids, 0x2::object::id<T0>(&arg2));
        0x2::object_table::add<0x2::object::ID, T0>(&mut arg1.tokens, 0x2::object::id<T0>(&arg2), arg2);
        let v3 = DepositTokenPoolEvent<T0, T1>{
            sender            : v0,
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg1),
            token_id          : 0x2::object::id<T0>(&arg2),
            coins             : 0x2::coin::value<T1>(&arg1.coins),
            spot_price        : arg1.spot_price,
            curve             : arg1.curve,
            delta             : arg1.delta,
            lp_fee_multiplier : arg1.lp_fee_multiplier,
        };
        0x2::event::emit<DepositTokenPoolEvent<T0, T1>>(v3);
    }

    public entry fun EditPool<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Pool<T0, T1>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(v0 == arg1.owner, 3242);
        arg1.curve = arg2;
        arg1.spot_price = arg3;
        arg1.delta = arg4;
        arg1.lp_fee_multiplier = arg5;
        let v3 = EditPoolEvent<T0, T1>{
            sender            : v0,
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg1),
            spot_price        : arg3,
            curve             : arg2,
            delta             : arg4,
            lp_fee_multiplier : arg5,
        };
        0x2::event::emit<EditPoolEvent<T0, T1>>(v3);
    }

    public entry fun SwapCoinForSpecificNFTS<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::Config, arg2: &mut Pool<T0, T1>, arg3: address, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(0x2::object_table::contains<0x2::object::ID, T0>(&arg2.tokens, 0x2::object::id_from_address(arg3)), 123);
        let (v3, v4, v5, v6, v7) = if (arg2.curve == 1) {
            let (v8, v9, v10, v11, v12, v13) = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::LinearCurve::getBuyInfo(arg2.spot_price, arg2.delta, 1, arg2.lp_fee_multiplier, 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_fee(arg1));
            let _ = v10;
            (v8, v9, v11, v12, v13)
        } else {
            assert!(arg2.curve == 2, 532);
            let (v15, v16, v17, v18, v19, v20) = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::ExponentialCurve::getBuyInfo(arg2.spot_price, arg2.delta, 1, arg2.lp_fee_multiplier, 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_fee(arg1));
            let _ = v17;
            (v15, v16, v18, v19, v20)
        };
        assert!(v3 == 0, 34);
        arg2.spot_price = v4;
        assert!(v5 <= 0x2::coin::value<T1>(arg4), 35);
        let v21 = 0x2::coin::split<T1>(arg4, v5, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v21, v6, arg5), 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_payee(arg1));
        arg2.lp_fee_earnings = arg2.lp_fee_earnings + v7;
        arg2.total_transaction_value = arg2.total_transaction_value + (v5 as u128);
        arg2.transactions = arg2.transactions + 1;
        0x2::coin::join<T1>(&mut arg2.coins, v21);
        let v22 = 0x2::object::id_from_address(arg3);
        let (v23, v24) = 0x1::vector::index_of<0x2::object::ID>(&arg2.token_ids, &v22);
        assert!(v23, 35);
        0x1::vector::remove<0x2::object::ID>(&mut arg2.token_ids, v24);
        0x2::transfer::public_transfer<T0>(0x2::object_table::remove<0x2::object::ID, T0>(&mut arg2.tokens, 0x2::object::id_from_address(arg3)), v0);
        let v25 = SwapEvent<T0, T1>{
            sender            : v0,
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg2),
            spot_price        : arg2.spot_price,
            curve             : arg2.curve,
            delta             : arg2.delta,
            coins             : 0x2::coin::value<T1>(&arg2.coins),
            lp_fee_multiplier : arg2.lp_fee_multiplier,
            token_id          : 0x2::object::id_from_address(arg3),
            coin_amount       : v5,
            protocol_fee      : v6,
            protocol_payee    : 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_payee(arg1),
            royalty_fee       : 0,
            royalty_payee     : @0x0,
            lp_fee            : v7,
            type              : 0x1::string::utf8(b"buy"),
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v25);
    }

    public entry fun SwapNFTsForCoin<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::Config, arg2: &mut Pool<T0, T1>, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        let (v3, v4, v5, v6, v7) = if (arg2.curve == 1) {
            let (v8, v9, v10, v11, v12, v13) = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::LinearCurve::getSellInfo(arg2.spot_price, arg2.delta, 1, arg2.lp_fee_multiplier, 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_fee(arg1));
            let _ = v10;
            (v8, v9, v11, v12, v13)
        } else {
            assert!(arg2.curve == 2, 532);
            let (v15, v16, v17, v18, v19, v20) = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::ExponentialCurve::getSellInfo(arg2.spot_price, arg2.delta, 1, arg2.lp_fee_multiplier, 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_fee(arg1));
            let _ = v17;
            (v15, v16, v18, v19, v20)
        };
        assert!(v3 == 0, 34);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.token_ids, 0x2::object::id<T0>(&arg3));
        0x2::object_table::add<0x2::object::ID, T0>(&mut arg2.tokens, 0x2::object::id<T0>(&arg3), arg3);
        arg2.spot_price = v4;
        assert!(0x2::coin::value<T1>(&arg2.coins) >= v5, 421);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2.coins, v6, arg4), 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_payee(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2.coins, v5, arg4), v0);
        arg2.spot_price = v4;
        arg2.lp_fee_earnings = arg2.lp_fee_earnings + v7;
        arg2.total_transaction_value = arg2.total_transaction_value + (v5 as u128);
        arg2.transactions = arg2.transactions + 1;
        let v21 = SwapEvent<T0, T1>{
            sender            : v0,
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg2),
            spot_price        : arg2.spot_price,
            curve             : arg2.curve,
            delta             : arg2.delta,
            coins             : 0x2::coin::value<T1>(&arg2.coins),
            lp_fee_multiplier : arg2.lp_fee_multiplier,
            token_id          : 0x2::object::id<T0>(&arg3),
            coin_amount       : v5,
            protocol_fee      : v6,
            protocol_payee    : 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config::get_protocol_payee(arg1),
            royalty_fee       : 0,
            royalty_payee     : @0x0,
            lp_fee            : v7,
            type              : 0x1::string::utf8(b"sell"),
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v21);
    }

    public entry fun WithdrawCoinAndTransfer<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(v0 == arg1.owner, 3242);
        assert!(0x2::coin::value<T1>(&arg1.coins) >= arg2, 463);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1.coins, arg2, arg4), arg3);
        let v3 = WithdrawCoinPoolEvent<T0, T1>{
            sender               : v0,
            to                   : arg3,
            pool_id              : 0x2::object::id<Pool<T0, T1>>(arg1),
            withdraw_coin_amount : arg2,
            coins                : 0x2::coin::value<T1>(&arg1.coins),
            spot_price           : arg1.spot_price,
            curve                : arg1.curve,
            delta                : arg1.delta,
            lp_fee_multiplier    : arg1.lp_fee_multiplier,
        };
        0x2::event::emit<WithdrawCoinPoolEvent<T0, T1>>(v3);
    }

    public entry fun WithdrawTokenAndTransfer<T0: store + key, T1>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Pool<T0, T1>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<POOL>();
        let v2 = 0x1::type_name::get_address(&v1);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v2)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(v0 == arg1.owner, 3242);
        assert!(0x2::object_table::contains<0x2::object::ID, T0>(&arg1.tokens, 0x2::object::id_from_address(arg2)), 45235);
        let v3 = 0x2::object_table::remove<0x2::object::ID, T0>(&mut arg1.tokens, 0x2::object::id_from_address(arg2));
        let v4 = 0x2::object::id_from_address(arg2);
        let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(&arg1.token_ids, &v4);
        assert!(v5, 35);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.token_ids, v6);
        0x2::transfer::public_transfer<T0>(v3, arg3);
        let v7 = WithdrawTokenPoolEvent<T0, T1>{
            sender            : v0,
            to                : arg3,
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg1),
            token_id          : 0x2::object::id<T0>(&v3),
            coins             : 0x2::coin::value<T1>(&arg1.coins),
            spot_price        : arg1.spot_price,
            curve             : arg1.curve,
            delta             : arg1.delta,
            lp_fee_multiplier : arg1.lp_fee_multiplier,
        };
        0x2::event::emit<WithdrawTokenPoolEvent<T0, T1>>(v7);
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
    }

    public entry fun view_price_calc(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = if (arg0 == 0) {
            let (v5, v6, v7, v8, v9, v10) = if (arg1 == 1) {
                let (v11, v12, v13, v14, v15, v16) = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::LinearCurve::getBuyInfo(arg2, arg3, arg4, arg5, arg6);
                (v14, v15, v16, v11, v12, v13)
            } else {
                assert!(arg1 == 2, 12);
                let (v17, v18, v19, v20, v21, v22) = 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::ExponentialCurve::getBuyInfo(arg2, arg3, arg4, arg5, arg6);
                (v20, v21, v22, v17, v18, v19)
            };
            let _ = v10;
            (v8, v9, v5, v6, v7)
        } else {
            let (v24, v25, v26, v27, v28, v29) = if (arg1 == 1) {
                0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::LinearCurve::getSellInfo(arg2, arg3, arg4, arg5, arg6)
            } else {
                assert!(arg1 == 2, 12);
                0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::ExponentialCurve::getSellInfo(arg2, arg3, arg4, arg5, arg6)
            };
            let _ = v26;
            (v24, v25, v27, v28, v29)
        };
        assert!(v0 == 0, 1351);
        (v1, v2, v3, v4)
    }

    // decompiled from Move bytecode v6
}

