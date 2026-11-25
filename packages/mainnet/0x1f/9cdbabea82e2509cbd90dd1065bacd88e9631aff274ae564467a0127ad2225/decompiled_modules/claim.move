module 0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::claim {
    struct ClaimParams has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
        initialized: bool,
        details: 0x1::option::Option<ClaimDetails>,
        wallet: address,
        shareWallet: address,
    }

    struct ClaimDetails has copy, drop, store {
        coin_details: vector<CoinDetail>,
    }

    struct CoinDetail has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    entry fun claim_and_distribute<T0>(arg0: &0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::State, arg1: &0x2::clock::Clock, arg2: &mut ClaimParams, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg2.delegate, 0);
        if (!0xd51017251e888ac64f26250bf0fbf968a90d661ee01b81c7873a99d0e87a4c6f::state::live(arg0, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
            return
        };
        assert!(0x1::option::is_some<ClaimDetails>(&arg2.details), 1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = 0;
        let v3 = 0x1::option::borrow_mut<ClaimDetails>(&mut arg2.details);
        let v4 = false;
        let v5 = 0;
        while (v5 < 0x1::vector::length<CoinDetail>(&v3.coin_details)) {
            let v6 = 0x1::vector::borrow<CoinDetail>(&v3.coin_details, v5);
            if (v6.coin_type == normalise_coin_type(&v1) && v6.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg3)) {
                v4 = true;
                v2 = v6.amount;
                break
            };
            v5 = v5 + 1;
        };
        assert!(v4, 3);
        0x1::vector::swap_remove<CoinDetail>(&mut v3.coin_details, v5);
        if (0x1::vector::is_empty<CoinDetail>(&v3.coin_details)) {
            arg2.details = 0x1::option::none<ClaimDetails>();
        };
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 2);
        if (v2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        } else {
            let v7 = 0x2::coin::split<T0>(&mut arg3, v2, arg4);
            let v8 = v2 * 30 / 100;
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v7, v8, arg4), arg2.shareWallet);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, arg2.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        };
    }

    entry fun create_claim_params(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimParams{
            id          : 0x2::object::new(arg3),
            owner       : 0x2::tx_context::sender(arg3),
            delegate    : arg0,
            initialized : false,
            details     : 0x1::option::none<ClaimDetails>(),
            wallet      : arg1,
            shareWallet : arg2,
        };
        0x2::transfer::share_object<ClaimParams>(v0);
    }

    fun normalise_coin_type(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 + 1 < v1) {
            let v4 = 58;
            let v5 = if (0x1::vector::borrow<u8>(&v0, v3) == &v4) {
                let v6 = 58;
                0x1::vector::borrow<u8>(&v0, v3 + 1) == &v6
            } else {
                false
            };
            if (v5) {
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        if (v2 == 0) {
            return 0x1::ascii::string(v0)
        };
        let v7 = 0;
        let v8 = if (v2 >= 2) {
            let v9 = 48;
            if (0x1::vector::borrow<u8>(&v0, 0) == &v9) {
                let v10 = 120;
                0x1::vector::borrow<u8>(&v0, 1) == &v10
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            v7 = 2;
        };
        let v11 = b"";
        let v12 = 0;
        while (v12 < 64 - v2 - v7) {
            0x1::vector::push_back<u8>(&mut v11, 48);
            v12 = v12 + 1;
        };
        let v13 = v7;
        while (v13 < v2) {
            0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&v0, v13));
            v13 = v13 + 1;
        };
        let v14 = v2;
        while (v14 < v1) {
            0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&v0, v14));
            v14 = v14 + 1;
        };
        0x1::ascii::string(v11)
    }

    entry fun set_details(arg0: &mut ClaimParams, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2) && v0 == 0x1::vector::length<0x2::object::ID>(&arg3), 4);
        let v1 = 0x1::vector::empty<CoinDetail>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = CoinDetail{
                coin_type : normalise_coin_type(0x1::vector::borrow<0x1::ascii::String>(&arg1, v2)),
                amount    : *0x1::vector::borrow<u64>(&arg2, v2),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg3, v2),
            };
            0x1::vector::push_back<CoinDetail>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = ClaimDetails{coin_details: v1};
        arg0.details = 0x1::option::some<ClaimDetails>(v4);
        arg0.initialized = true;
    }

    // decompiled from Move bytecode v7
}

