module 0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::ido {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserInfo has store {
        amount: u64,
        claimed: bool,
        refunded: bool,
    }

    struct IDOStorage has key {
        id: 0x2::object::UID,
        stakeTokenBalance: 0x2::balance::Balance<0x2::sui::SUI>,
        offeringTokenBalance: 0x2::balance::Balance<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>,
        adminAddress: address,
        startTimestamp: u64,
        endTimestamp: u64,
        raisingAmount: u64,
        offeringAmount: u64,
        totalAmount: u64,
        totalDebt: u64,
        userInfo: 0x2::table::Table<address, UserInfo>,
        addressList: vector<address>,
        harvestReleaseTimestamp: u64,
        minAmount: u64,
        maxAmount: u64,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
    }

    struct HarvestEvent has copy, drop, store {
        user: address,
        offeringAmount: u64,
        excessAmount: u64,
    }

    struct UpdateOfferingAmount has copy, drop, store {
        previousOfferingAmount: u64,
        newOfferingAmount: u64,
    }

    struct UpdateRaisingAmount has copy, drop, store {
        previousRaisingAmount: u64,
        newRaisingAmount: u64,
    }

    struct AdminFinalWithdraw has copy, drop, store {
        stakeTokenAmount: u64,
        offerAmount: u64,
    }

    public entry fun add_wl(arg0: &AdminCap, arg1: &mut 0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::Whitelist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::add_investor(arg1, arg2);
    }

    public entry fun add_wl_bulk(arg0: &AdminCap, arg1: &mut 0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::Whitelist, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::add_to_whitelist(arg1, arg2);
    }

    public entry fun deposit(arg0: &mut IDOStorage, arg1: &mut 0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::Whitelist, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) > arg0.startTimestamp, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::contains(arg1, v0) == true, 8);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.stakeTokenBalance, 0x2::coin::take<0x2::sui::SUI>(&mut v1, arg2, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), v0);
        let v2 = getTotalStakeTokenBalance(arg0) - getTotalStakeTokenBalance(arg0);
        assert!(v2 > 0, 1);
        depositInternal(arg0, v2, arg5);
        0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::whitelist::investor_invested(arg1, v0);
    }

    fun depositInternal(arg0: &mut IDOStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, UserInfo>(&arg0.userInfo, v0) == false) {
            assert!(arg1 >= arg0.minAmount && arg1 <= arg0.maxAmount, 7);
            let v1 = UserInfo{
                amount   : arg1,
                claimed  : false,
                refunded : false,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.userInfo, v0, v1);
            0x1::vector::push_back<address>(&mut arg0.addressList, v0);
        } else {
            let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.userInfo, v0);
            assert!(v2.amount + arg1 <= arg0.maxAmount, 7);
            v2.amount = v2.amount + arg1;
        };
        arg0.totalAmount = arg0.totalAmount + arg1;
        arg0.totalDebt = arg0.totalDebt + arg1;
        let v3 = DepositEvent{
            user   : v0,
            amount : arg1,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public entry fun extend(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.startTimestamp = arg1.startTimestamp + arg2;
        arg1.endTimestamp = arg1.endTimestamp + arg2;
        arg1.harvestReleaseTimestamp = arg1.harvestReleaseTimestamp + arg2;
    }

    public entry fun extend_claim(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.harvestReleaseTimestamp = arg1.harvestReleaseTimestamp + arg2;
    }

    public entry fun extend_end(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.endTimestamp = arg1.endTimestamp + arg2;
    }

    public entry fun extend_start(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.startTimestamp = arg1.startTimestamp + arg2;
    }

    public entry fun finalWithdraw(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        safeTransferStakeInternal(arg1, v0, arg2, arg4);
        if (arg3 > 0) {
            assert!(arg3 <= 0x2::balance::value<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&arg1.offeringTokenBalance), 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>>(0x2::coin::take<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&mut arg1.offeringTokenBalance, arg3, arg4), v0);
        };
        let v1 = AdminFinalWithdraw{
            stakeTokenAmount : arg2,
            offerAmount      : arg3,
        };
        0x2::event::emit<AdminFinalWithdraw>(v1);
    }

    public entry fun fund(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: 0x2::coin::Coin<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&mut arg1.offeringTokenBalance, 0x2::coin::split<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&mut arg2, arg1.offeringAmount, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>>(arg2, 0x2::tx_context::sender(arg3));
    }

    public fun getAddressListLength(arg0: &IDOStorage) : u64 {
        0x1::vector::length<address>(&arg0.addressList)
    }

    public fun getDebt(arg0: &IDOStorage) : u64 {
        arg0.totalDebt
    }

    public fun getEndTime(arg0: &IDOStorage) : u64 {
        arg0.endTimestamp
    }

    public fun getHarvestTime(arg0: &IDOStorage) : u64 {
        arg0.harvestReleaseTimestamp
    }

    public fun getOfferingAmount(arg0: &IDOStorage, arg1: address) : u64 {
        if (arg0.totalAmount > arg0.raisingAmount) {
            return (((0x2::table::borrow<address, UserInfo>(&arg0.userInfo, arg1).amount as u256) * (arg0.offeringAmount as u256) / (arg0.totalAmount as u256)) as u64)
        };
        (((0x2::table::borrow<address, UserInfo>(&arg0.userInfo, arg1).amount as u256) * (arg0.offeringAmount as u256) / (arg0.raisingAmount as u256)) as u64)
    }

    public fun getRaised(arg0: &IDOStorage) : u64 {
        arg0.totalAmount
    }

    public fun getRefundingAmount(arg0: &IDOStorage, arg1: address) : u64 {
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.userInfo, arg1);
        if (arg0.totalAmount <= arg0.raisingAmount || v0.refunded == true) {
            return 0
        };
        let v1 = v0.amount;
        v1 - (((v1 as u256) * (arg0.raisingAmount as u256) / (arg0.totalAmount as u256)) as u64)
    }

    public fun getStartTime(arg0: &IDOStorage) : u64 {
        arg0.startTimestamp
    }

    public fun getTotalStakeTokenBalance(arg0: &IDOStorage) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.stakeTokenBalance)
    }

    public fun getUserAllocation(arg0: &IDOStorage, arg1: address) : u64 {
        if (arg0.totalAmount == 0) {
            return 0
        };
        (((0x2::table::borrow<address, UserInfo>(&arg0.userInfo, arg1).amount as u256) * 1000000000000 / (arg0.totalAmount as u256)) as u64)
    }

    public entry fun harvest(arg0: &0x2::clock::Clock, arg1: &mut IDOStorage, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::clock::timestamp_ms(arg0) > arg1.harvestReleaseTimestamp, 4);
        let v1 = getRefundingAmount(arg1, v0);
        if (v1 > 0) {
            safeTransferStakeInternal(arg1, v0, v1, arg2);
            0x2::table::borrow_mut<address, UserInfo>(&mut arg1.userInfo, v0).refunded = true;
        };
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.userInfo, v0);
        assert!(v2.amount > 0, 5);
        assert!(!v2.claimed, 6);
        v2.claimed = true;
        arg1.totalDebt = arg1.totalDebt - v2.amount;
        let v3 = getOfferingAmount(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>>(0x2::coin::take<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&mut arg1.offeringTokenBalance, v3, arg2), v0);
        let v4 = HarvestEvent{
            user           : v0,
            offeringAmount : v3,
            excessAmount   : v1,
        };
        0x2::event::emit<HarvestEvent>(v4);
    }

    public fun hasHarvested(arg0: &IDOStorage, arg1: address) : bool {
        0x2::table::borrow<address, UserInfo>(&arg0.userInfo, arg1).claimed
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IDOStorage{
            id                      : 0x2::object::new(arg0),
            stakeTokenBalance       : 0x2::balance::zero<0x2::sui::SUI>(),
            offeringTokenBalance    : 0x2::balance::zero<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(),
            adminAddress            : @0x5b116671d0d21ea7f80065379a2f78377de8907d91c9f2b36584920917189067,
            startTimestamp          : 1683894061755,
            endTimestamp            : 1683896291755,
            raisingAmount           : 100000000000000,
            offeringAmount          : 1000000000000000,
            totalAmount             : 0,
            totalDebt               : 0,
            userInfo                : 0x2::table::new<address, UserInfo>(arg0),
            addressList             : 0x1::vector::empty<address>(),
            harvestReleaseTimestamp : 1683896291755,
            minAmount               : 10000000000,
            maxAmount               : 1000000000000,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<IDOStorage>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun reset(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        arg1.totalAmount = 0;
        arg1.totalDebt = 0;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.stakeTokenBalance);
        let v2 = 0x2::balance::value<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&arg1.offeringTokenBalance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.stakeTokenBalance, v1, arg2), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>>(0x2::coin::take<0xd735282698c3093adf91c59ba5fa3294112d7dd713beb4f7753eac4637bd47a1::bark::BARK>(&mut arg1.offeringTokenBalance, v2, arg2), v0);
        };
    }

    fun safeTransferStakeInternal(arg0: &mut IDOStorage, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        assert!(arg2 <= getTotalStakeTokenBalance(arg0), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stakeTokenBalance, arg2, arg3), arg1);
    }

    public entry fun setOfferingAmount(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.startTimestamp, 0);
        let v0 = UpdateOfferingAmount{
            previousOfferingAmount : arg1.offeringAmount,
            newOfferingAmount      : arg3,
        };
        0x2::event::emit<UpdateOfferingAmount>(v0);
        arg1.offeringAmount = arg3;
    }

    public entry fun setRaisingAmount(arg0: &AdminCap, arg1: &mut IDOStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.startTimestamp, 0);
        let v0 = UpdateRaisingAmount{
            previousRaisingAmount : arg1.raisingAmount,
            newRaisingAmount      : arg3,
        };
        0x2::event::emit<UpdateRaisingAmount>(v0);
        arg1.raisingAmount = arg3;
    }

    public fun userTokenStatus(arg0: &IDOStorage, arg1: &0x2::clock::Clock, arg2: address) : (u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.userInfo, arg2);
        if (v0 < arg0.endTimestamp) {
            return (0, 0, 0)
        };
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        let v5 = v4;
        if (v0 >= arg0.harvestReleaseTimestamp && !v1.claimed) {
            v3 = v2 + getOfferingAmount(arg0, arg2);
        } else if (v0 < arg0.harvestReleaseTimestamp) {
            v5 = v4 + getOfferingAmount(arg0, arg2);
        };
        (getRefundingAmount(arg0, arg2), v3, v5)
    }

    // decompiled from Move bytecode v6
}

