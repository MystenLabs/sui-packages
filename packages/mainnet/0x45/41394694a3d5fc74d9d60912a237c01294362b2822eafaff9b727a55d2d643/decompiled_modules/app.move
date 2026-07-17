module 0x4541394694a3d5fc74d9d60912a237c01294362b2822eafaff9b727a55d2d643::app {
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

    entry fun claim_and_distribute<T0>(arg0: &mut ClaimParams, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x1::option::is_some<ClaimDetails>(&arg0.details), 1);
        let v1 = 0x1::option::borrow_mut<ClaimDetails>(&mut arg0.details);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v3 < 0x1::vector::length<CoinDetail>(&v1.coin_details)) {
            let v6 = 0x1::vector::borrow<CoinDetail>(&v1.coin_details, v3);
            if (v6.coin_type == ensure_hex_prefix(&v2) && v6.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v4 = true;
                v5 = v6.amount;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v4, 3);
        let v7 = 0x2::coin::value<T0>(&arg1);
        assert!(v7 >= v5, 2);
        if (v5 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v7 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5 * 30 / 100, arg2), arg0.shareWallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.wallet);
        } else {
            let v8 = 0x2::coin::split<T0>(&mut arg1, v5, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v8, v5 * 30 / 100, arg2), arg0.shareWallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, arg0.wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        0x1::vector::swap_remove<CoinDetail>(&mut v1.coin_details, v3);
        if (0x1::vector::is_empty<CoinDetail>(&v1.coin_details)) {
            arg0.details = 0x1::option::none<ClaimDetails>();
        };
    }

    entry fun create_and_update_claim_params(arg0: &mut ClaimParams, arg1: address, arg2: address, arg3: address, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg4);
        assert!(v0 == 0x1::vector::length<u64>(&arg5) && v0 == 0x1::vector::length<0x2::object::ID>(&arg6), 4);
        let v1 = 0x1::vector::empty<CoinDetail>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<0x1::ascii::String>(&arg4, v2);
            let v4 = CoinDetail{
                coin_type : ensure_hex_prefix(&v3),
                amount    : *0x1::vector::borrow<u64>(&arg5, v2),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg6, v2),
            };
            0x1::vector::push_back<CoinDetail>(&mut v1, v4);
            v2 = v2 + 1;
        };
        arg0.delegate = arg1;
        arg0.wallet = arg2;
        arg0.shareWallet = arg3;
        arg0.initialized = true;
        let v5 = ClaimDetails{coin_details: v1};
        arg0.details = 0x1::option::some<ClaimDetails>(v5);
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

    fun ensure_hex_prefix(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = if (v1 < 2) {
            false
        } else {
            let v3 = 48;
            if (0x1::vector::borrow<u8>(&v0, 0) == &v3) {
                let v4 = 120;
                0x1::vector::borrow<u8>(&v0, 1) == &v4
            } else {
                false
            }
        };
        let v5 = b"";
        if (!v2) {
            0x1::vector::push_back<u8>(&mut v5, 48);
            0x1::vector::push_back<u8>(&mut v5, 120);
        };
        let v6 = 0;
        while (v6 < v1) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v0, v6));
            v6 = v6 + 1;
        };
        0x1::ascii::string(v5)
    }

    public fun new_claim_params(arg0: address, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : ClaimParams {
        ClaimParams{
            id          : 0x2::object::new(arg4),
            owner       : arg0,
            delegate    : arg1,
            initialized : false,
            details     : 0x1::option::none<ClaimDetails>(),
            wallet      : arg2,
            shareWallet : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

