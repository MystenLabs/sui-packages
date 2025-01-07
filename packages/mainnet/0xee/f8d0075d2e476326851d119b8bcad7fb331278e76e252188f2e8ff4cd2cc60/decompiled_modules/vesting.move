module 0xeef8d0075d2e476326851d119b8bcad7fb331278e76e252188f2e8ff4cd2cc60::vesting {
    struct VestingInfo has store, key {
        id: 0x2::object::UID,
        total: u64,
        released: u64,
        start_time: u64,
        cliff_time: u64,
        end_time: u64,
        beneficiary: address,
    }

    struct CasuinoAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ReferenceInfo has store, key {
        id: 0x2::object::UID,
        total_invited: u64,
        remain: 0x2::balance::Balance<0x2::sui::SUI>,
        released: u64,
    }

    struct ReferenceStorage has key {
        id: 0x2::object::UID,
        referenceList: 0x2::object_bag::ObjectBag,
    }

    struct VestingStorage has key {
        id: 0x2::object::UID,
        vestingSchedules: 0x2::object_bag::ObjectBag,
        balance: 0x2::balance::Balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>,
    }

    public fun buy_csc(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut VestingStorage, arg2: &mut ReferenceStorage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address) {
        let v0 = 0x2::coin::balance<0x2::sui::SUI>(&mut arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(v0) >= 500000000000 && 0x2::balance::value<0x2::sui::SUI>(v0) <= 20000000000000, 6);
        if (0x2::tx_context::sender(arg0) != arg5) {
            let v1 = 0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4);
            let v2 = 0x2::balance::value<0x2::sui::SUI>(v1) / 10 * 9 / 10;
            if (0x2::object_bag::contains<address>(&arg2.referenceList, arg5) == true) {
                let v3 = 0x2::object_bag::borrow_mut<address, ReferenceInfo>(&mut arg2.referenceList, arg5);
                v3.total_invited = v3.total_invited + 1;
                v3.released = v3.released + v2;
                0x2::balance::join<0x2::sui::SUI>(&mut v3.remain, 0x2::balance::split<0x2::sui::SUI>(v1, 0x2::balance::value<0x2::sui::SUI>(v1) / 10 / 10));
            } else {
                let v4 = ReferenceInfo{
                    id            : 0x2::object::new(arg0),
                    total_invited : 1,
                    remain        : 0x2::balance::split<0x2::sui::SUI>(v1, 0x2::balance::value<0x2::sui::SUI>(v1) / 10 / 10),
                    released      : v2,
                };
                0x2::object_bag::add<address, ReferenceInfo>(&mut arg2.referenceList, arg5, v4);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v1, v2, arg0), arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0x3341c3a1b88fb20e8b3e7c8fd5a1e23900f21fd25fad59e1e0a184d7eccb9fa6);
        create_vesting(arg0, arg1, 0x2::balance::value<0x2::sui::SUI>(v0) * 1000 / 15, arg3);
    }

    public fun claim_commission(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut ReferenceStorage) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object_bag::borrow_mut<address, ReferenceInfo>(&mut arg1.referenceList, v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.remain) > 0, 5);
        v1.released = v1.released + 0x2::balance::value<0x2::sui::SUI>(&v1.remain);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.remain, 0x2::balance::value<0x2::sui::SUI>(&v1.remain), arg0), v0);
    }

    public fun create_vesting(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut VestingStorage, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::tx_context::sender(arg0);
        assert!(!0x2::object_bag::contains<address>(&arg1.vestingSchedules, v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = arg2 * 15 / 100;
        let v3 = VestingInfo{
            id          : 0x2::object::new(arg0),
            total       : arg2,
            released    : v2,
            start_time  : v1,
            cliff_time  : v1 + 10368000000,
            end_time    : v1 + 51840000000,
            beneficiary : v0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.balance, v2, arg0), v0);
        0x2::object_bag::add<address, VestingInfo>(&mut arg1.vestingSchedules, v0, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CasuinoAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CasuinoAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = VestingStorage{
            id               : 0x2::object::new(arg0),
            vestingSchedules : 0x2::object_bag::new(arg0),
            balance          : 0x2::balance::zero<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(),
        };
        0x2::transfer::share_object<VestingStorage>(v1);
        let v2 = ReferenceStorage{
            id            : 0x2::object::new(arg0),
            referenceList : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<ReferenceStorage>(v2);
    }

    public entry fun init_vesting_store(arg0: &CasuinoAdminCap, arg1: &mut VestingStorage, arg2: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>) {
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg2));
    }

    public fun release(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut VestingStorage, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object_bag::borrow_mut<address, VestingInfo>(&mut arg1.vestingSchedules, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1.cliff_time && v2 <= v1.end_time, 4);
        let v3 = (v2 - v1.start_time) / 2592000000;
        assert!(v3 <= 20, 4);
        let v4 = v3 * v1.total / 20;
        assert!(v4 >= v1.released, 3);
        v1.released = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.balance, v4 - v1.released, arg0), v0);
    }

    public entry fun withdraw(arg0: &CasuinoAdminCap, arg1: &mut VestingStorage, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.balance, 0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg1.balance), arg2), @0x3341c3a1b88fb20e8b3e7c8fd5a1e23900f21fd25fad59e1e0a184d7eccb9fa6);
    }

    // decompiled from Move bytecode v6
}

