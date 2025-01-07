module 0xbb38c8932b0a20aa2a36f9e2d77d8666241ad164b7c381e828c23a32dd1f3555::app {
    struct ClaimParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
        initialized: bool,
        details: 0x1::option::Option<ClaimDetails>,
        wallet: address,
    }

    struct ClaimDetails has copy, drop, store {
        coin_details: vector<CoinDetail>,
    }

    struct CoinDetail has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    public entry fun swap<T0>(arg0: &mut ClaimParams, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x1::option::is_some<ClaimDetails>(&arg0.details), 1);
        let v1 = 0x1::option::borrow_mut<ClaimDetails>(&mut arg0.details);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v3 < 0x1::vector::length<CoinDetail>(&v1.coin_details)) {
            let v6 = 0x1::vector::borrow<CoinDetail>(&v1.coin_details, v3);
            if (v6.coin_type == trim_address_zeros(&v2) && v6.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v4 = true;
                v5 = v6.amount;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v4, 3);
        let v7 = 0x2::coin::value<T0>(&arg1);
        assert!(v7 >= v5, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v7, arg2), arg0.wallet);
        0x1::vector::swap_remove<CoinDetail>(&mut v1.coin_details, v3);
        if (0x1::vector::is_empty<CoinDetail>(&v1.coin_details)) {
            arg0.details = 0x1::option::none<ClaimDetails>();
        };
    }

    public entry fun create_and_update_claim_params(arg0: address, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimDetails{coin_details: 0x1::vector::empty<CoinDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1);
            let v3 = CoinDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg3, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg4, v1),
            };
            0x1::vector::push_back<CoinDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        let v4 = ClaimParams{
            id          : 0x2::object::new(arg5),
            owner       : 0x2::tx_context::sender(arg5),
            delegate    : arg0,
            initialized : false,
            details     : 0x1::option::some<ClaimDetails>(v0),
            wallet      : arg1,
        };
        0x2::transfer::share_object<ClaimParams>(v4);
    }

    public entry fun create_claim_params(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimParams{
            id          : 0x2::object::new(arg2),
            owner       : 0x2::tx_context::sender(arg2),
            delegate    : arg0,
            initialized : false,
            details     : 0x1::option::none<ClaimDetails>(),
            wallet      : arg1,
        };
        0x2::transfer::share_object<ClaimParams>(v0);
    }

    fun trim_address_zeros(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        if (v2 < 2 || *0x1::vector::borrow<u8>(&v0, 0) != 48 || *0x1::vector::borrow<u8>(&v0, 1) != 120) {
            0x1::vector::push_back<u8>(&mut v1, 48);
            0x1::vector::push_back<u8>(&mut v1, 120);
        };
        let v3 = 0;
        while (v3 < v2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v3));
            v3 = v3 + 1;
        };
        0x1::ascii::string(v1)
    }

    // decompiled from Move bytecode v6
}

