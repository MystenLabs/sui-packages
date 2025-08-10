module 0x7595ad0a79228628cf186c3ae70d0c94e78b8071a7dcaaab3e7104cd87b8af84::nft_core {
    struct Root has store, key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
        fee: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        package: 0x1::string::String,
        name: 0x1::string::String,
        mint_groups: vector<MintGroup>,
    }

    struct MintGroup has drop, store {
        name: 0x1::string::String,
        merkle_root: 0x1::option::Option<vector<u8>>,
        max_mints_per_wallet: u64,
        reserved_supply: u64,
        start_time: u64,
        end_time: u64,
        payments: u8,
    }

    struct Payment<phantom T0> has drop, store {
        coin: 0x1::string::String,
        routes: vector<PaymentRoute>,
    }

    struct PaymentRoute has drop, store {
        method: 0x1::string::String,
        amount: u64,
        destination: 0x1::option::Option<address>,
    }

    struct Minted has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct NFT_CORE has drop {
        dummy_field: bool,
    }

    fun create_payment<T0>(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<0x1::option::Option<address>>) : Payment<T0> {
        let v0 = Payment<T0>{
            coin   : arg0,
            routes : 0x1::vector::empty<PaymentRoute>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            if (*0x1::vector::borrow<0x1::string::String>(&arg1, v1) != 0x1::string::utf8(b"transfer") && *0x1::vector::borrow<0x1::string::String>(&arg1, v1) != 0x1::string::utf8(b"burn")) {
                abort 261
            };
            let v2 = PaymentRoute{
                method      : *0x1::vector::borrow<0x1::string::String>(&arg1, v1),
                amount      : *0x1::vector::borrow<u64>(&arg2, v1),
                destination : *0x1::vector::borrow<0x1::option::Option<address>>(&arg3, v1),
            };
            0x1::vector::push_back<PaymentRoute>(&mut v0.routes, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: NFT_CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Root{
            id      : 0x2::object::new(arg1),
            admin   : 0x2::tx_context::sender(arg1),
            version : 1,
            fee     : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_CORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Root>(v0);
    }

    entry fun migrate(arg0: &mut Root, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.version = 1;
    }

    fun pay<T0>(arg0: &Payment<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::length<PaymentRoute>(&arg0.routes);
        let v1 = &mut arg1;
        if (v0 == 1) {
            let v2 = 0x1::vector::borrow<PaymentRoute>(&arg0.routes, 0);
            if (v2.method == 0x1::string::utf8(b"burn")) {
                let v3 = b"000000000000000000000000000000000000000000000000000000000000dead";
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v2.amount * arg2, arg3), 0x2::address::from_ascii_bytes(&v3));
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v2.amount * arg2, arg3), *0x1::option::borrow<address>(&v2.destination));
            };
        } else {
            let v4 = 0;
            while (v4 < v0) {
                let v5 = 0x1::vector::borrow<PaymentRoute>(&arg0.routes, v4);
                if (v5.method == 0x1::string::utf8(b"burn")) {
                    let v6 = b"000000000000000000000000000000000000000000000000000000000000dead";
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v5.amount * arg2, arg3), 0x2::address::from_ascii_bytes(&v6));
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v5.amount * arg2, arg3), *0x1::option::borrow<address>(&v5.destination));
                };
                v4 = v4 + 1;
            };
        };
        arg1
    }

    fun pay_fee<T0>(arg0: &Root, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.fee * arg2;
        if (v0 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg3), arg0.admin);
        };
        arg1
    }

    public entry fun register_collection(arg0: &mut 0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id          : 0x2::object::new(arg2),
            package     : 0x1::string::from_ascii(*0x2::package::published_package(arg0)),
            name        : arg1,
            mint_groups : 0x1::vector::empty<MintGroup>(),
        };
        0x2::transfer::public_share_object<Collection>(v0);
    }

    public entry fun set_payments<T0, T1, T2, T3>(arg0: &mut Collection, arg1: &mut 0x2::package::Publisher, arg2: u64, arg3: 0x1::option::Option<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: vector<0x1::option::Option<address>>, arg7: 0x1::option::Option<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: vector<u64>, arg10: vector<0x1::option::Option<address>>, arg11: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x1::string::String>(&arg7) && 0x1::option::is_none<0x1::string::String>(&arg3)) {
            abort 258
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3) && 0x1::option::is_some<0x1::string::String>(&arg7)) {
            if (0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&arg3)) == 0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(&arg7))) {
                abort 259
            };
            let v0 = 0x1::type_name::get<T0>();
            let v1 = 0x1::type_name::get<T1>();
            if (0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0)) == 0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v1))) {
                abort 260
            };
        };
        let v2 = 0x1::string::utf8(b"payment_0_of_group_");
        0x1::string::append(&mut v2, 0x1::u64::to_string(arg2));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            0x2::dynamic_field::remove<0x1::string::String, Payment<T2>>(&mut arg0.id, v2);
        };
        let v3 = 0x1::string::utf8(b"payment_1_of_group_");
        0x1::string::append(&mut v3, 0x1::u64::to_string(arg2));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v3)) {
            0x2::dynamic_field::remove<0x1::string::String, Payment<T3>>(&mut arg0.id, v3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v4 = 0x1::string::utf8(b"payment_0_of_group_");
            0x1::string::append(&mut v4, 0x1::u64::to_string(arg2));
            0x2::dynamic_field::add<0x1::string::String, Payment<T0>>(&mut arg0.id, v4, create_payment<T0>(*0x1::option::borrow<0x1::string::String>(&arg3), arg4, arg5, arg6));
            0x1::vector::borrow_mut<MintGroup>(&mut arg0.mint_groups, arg2).payments = 1;
        };
        if (0x1::option::is_some<0x1::string::String>(&arg7)) {
            let v5 = 0x1::string::utf8(b"payment_1_of_group_");
            0x1::string::append(&mut v5, 0x1::u64::to_string(arg2));
            0x2::dynamic_field::add<0x1::string::String, Payment<T1>>(&mut arg0.id, v5, create_payment<T1>(*0x1::option::borrow<0x1::string::String>(&arg7), arg8, arg9, arg10));
            0x1::vector::borrow_mut<MintGroup>(&mut arg0.mint_groups, arg2).payments = 2;
        };
        if (0x1::option::is_none<0x1::string::String>(&arg3) && 0x1::option::is_none<0x1::string::String>(&arg7)) {
            0x1::vector::borrow_mut<MintGroup>(&mut arg0.mint_groups, arg2).payments = 0;
        };
    }

    public entry fun update_admin(arg0: &mut Root, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public entry fun update_collection(arg0: &mut Collection, arg1: &mut 0x2::package::Publisher, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::option::Option<vector<u8>>>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        arg0.name = arg2;
        let v0 = 0x1::vector::empty<MintGroup>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v2 = 0x1::string::utf8(b"minted_count_");
            0x1::string::append(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
                let v3 = Minted{
                    id     : 0x2::object::new(arg9),
                    amount : 0,
                };
                0x2::dynamic_field::add<0x1::string::String, Minted>(&mut arg0.id, v2, v3);
            };
            let v4 = MintGroup{
                name                 : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                merkle_root          : *0x1::vector::borrow<0x1::option::Option<vector<u8>>>(&arg4, v1),
                max_mints_per_wallet : *0x1::vector::borrow<u64>(&arg5, v1),
                reserved_supply      : *0x1::vector::borrow<u64>(&arg6, v1),
                start_time           : *0x1::vector::borrow<u64>(&arg7, v1),
                end_time             : *0x1::vector::borrow<u64>(&arg8, v1),
                payments             : 0,
            };
            0x1::vector::push_back<MintGroup>(&mut v0, v4);
            v1 = v1 + 1;
        };
        arg0.mint_groups = v0;
    }

    public entry fun update_fee(arg0: &mut Root, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.fee = arg1;
    }

    public entry fun validate<T0>(arg0: &mut Root, arg1: &mut Collection, arg2: vector<u64>, arg3: u64, arg4: 0x1::option::Option<vector<vector<u8>>>, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::borrow<MintGroup>(&arg1.mint_groups, arg3).payments == 1, 256);
        validate_internal(arg1, arg3, arg4, arg2, arg5, arg7);
        let v0 = 0x1::string::utf8(b"payment_0_of_group_");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, Payment<T0>>(&arg1.id, v0);
        let v2 = pay<T0>(v1, arg6, 0x1::vector::length<u64>(&arg2), arg7);
        let v3 = v2;
        if (v1.coin == 0x1::string::utf8(b"0x2::sui::SUI")) {
            v3 = pay_fee<T0>(arg0, v2, 0x1::vector::length<u64>(&arg2), arg7);
        };
        0x2::coin::destroy_zero<T0>(v3);
    }

    public entry fun validate_2<T0, T1>(arg0: &mut Root, arg1: &mut Collection, arg2: vector<u64>, arg3: u64, arg4: 0x1::option::Option<vector<vector<u8>>>, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::borrow<MintGroup>(&arg1.mint_groups, arg3).payments == 2, 257);
        validate_internal(arg1, arg3, arg4, arg2, arg5, arg8);
        let v0 = 0x1::string::utf8(b"payment_0_of_group_");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        let v1 = 0x2::dynamic_field::borrow<0x1::string::String, Payment<T0>>(&arg1.id, v0);
        let v2 = pay<T0>(v1, arg6, 0x1::vector::length<u64>(&arg2), arg8);
        let v3 = v2;
        let v4 = 0x1::string::utf8(b"payment_1_of_group_");
        0x1::string::append(&mut v4, 0x1::u64::to_string(arg3));
        let v5 = 0x2::dynamic_field::borrow<0x1::string::String, Payment<T1>>(&arg1.id, v4);
        let v6 = pay<T1>(v5, arg7, 0x1::vector::length<u64>(&arg2), arg8);
        let v7 = v6;
        if (v1.coin == 0x1::string::utf8(b"0x2::sui::SUI")) {
            v3 = pay_fee<T0>(arg0, v2, 0x1::vector::length<u64>(&arg2), arg8);
        } else if (v5.coin == 0x1::string::utf8(b"0x2::sui::SUI")) {
            v7 = pay_fee<T1>(arg0, v6, 0x1::vector::length<u64>(&arg2), arg8);
        };
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v7);
    }

    fun validate_internal(arg0: &mut Collection, arg1: u64, arg2: 0x1::option::Option<vector<vector<u8>>>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        let v1 = 0x1::vector::borrow_mut<MintGroup>(&mut arg0.mint_groups, arg1);
        if (v1.start_time > 0x2::clock::timestamp_ms(arg4)) {
            abort 262
        };
        if (v1.end_time != 0 && v1.end_time < 0x2::clock::timestamp_ms(arg4)) {
            abort 263
        };
        let v2 = 0x1::string::utf8(b"minted_count_");
        0x1::string::append(&mut v2, v1.name);
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, Minted>(&mut arg0.id, v2);
        if (v1.reserved_supply != 0 && v3.amount + v0 > v1.reserved_supply) {
            abort 264
        };
        v3.amount = v3.amount + v0;
        let v4 = 0x1::string::utf8(b"minted_count_in_");
        0x1::string::append(&mut v4, v1.name);
        0x1::string::append(&mut v4, 0x1::string::utf8(b"_of_"));
        0x1::string::append(&mut v4, 0x2::address::to_string(0x2::tx_context::sender(arg5)));
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v4)) {
            let v5 = 0x2::dynamic_field::borrow_mut<0x1::string::String, Minted>(&mut arg0.id, v4);
            if (v1.max_mints_per_wallet != 0 && v5.amount + v0 > v1.max_mints_per_wallet) {
                abort 265
            };
            v5.amount = v5.amount + v0;
        } else {
            if (v1.max_mints_per_wallet != 0 && v0 > v1.max_mints_per_wallet) {
                abort 265
            };
            let v6 = Minted{
                id     : 0x2::object::new(arg5),
                amount : v0,
            };
            0x2::dynamic_field::add<0x1::string::String, Minted>(&mut arg0.id, v4, v6);
        };
        let v7 = 0;
        while (v7 < v0) {
            0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut arg0.id, 0x1::u64::to_string(*0x1::vector::borrow<u64>(&arg3, v7)), 0x2::address::to_string(0x2::tx_context::sender(arg5)));
            v7 = v7 + 1;
        };
        if (0x1::option::is_some<vector<u8>>(&v1.merkle_root)) {
            if (0x1::option::is_none<vector<vector<u8>>>(&arg2)) {
                abort 272
            };
            let v8 = 0x1::option::borrow<vector<vector<u8>>>(&arg2);
            let v9 = 0x2::address::to_bytes(0x2::tx_context::sender(arg5));
            let v10 = 0x2::hash::keccak256(&v9);
            let v11 = 0;
            while (v11 < 0x1::vector::length<vector<u8>>(v8)) {
                let v12 = 0x1::vector::borrow<vector<u8>>(v8, v11);
                let v13 = if (0x7595ad0a79228628cf186c3ae70d0c94e78b8071a7dcaaab3e7104cd87b8af84::utils::bytes_less_than(&v10, v12)) {
                    0x7595ad0a79228628cf186c3ae70d0c94e78b8071a7dcaaab3e7104cd87b8af84::utils::concat_bytes(&v10, v12)
                } else {
                    0x7595ad0a79228628cf186c3ae70d0c94e78b8071a7dcaaab3e7104cd87b8af84::utils::concat_bytes(v12, &v10)
                };
                let v14 = v13;
                v10 = 0x2::hash::keccak256(&v14);
                v11 = v11 + 1;
            };
            if (!0x7595ad0a79228628cf186c3ae70d0c94e78b8071a7dcaaab3e7104cd87b8af84::utils::bytes_eq(&v10, 0x1::option::borrow<vector<u8>>(&v1.merkle_root))) {
                abort 273
            };
        };
    }

    public entry fun validate_unpaid(arg0: &mut Collection, arg1: vector<u64>, arg2: u64, arg3: 0x1::option::Option<vector<vector<u8>>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::borrow<MintGroup>(&arg0.mint_groups, arg2).payments == 0, 153);
        validate_internal(arg0, arg2, arg3, arg1, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

