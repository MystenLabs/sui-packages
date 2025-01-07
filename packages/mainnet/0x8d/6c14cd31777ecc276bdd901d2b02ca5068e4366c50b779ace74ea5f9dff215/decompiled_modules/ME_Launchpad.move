module 0x8d6c14cd31777ecc276bdd901d2b02ca5068e4366c50b779ace74ea5f9dff215::ME_Launchpad {
    struct Launchpad has key {
        id: 0x2::object::UID,
        soft_cap: u64,
        start_time: u64,
        end_time: u64,
        total_tokens: u64,
        deposits: vector<Deposit>,
        raised: 0x2::balance::Balance<0x2::sui::SUI>,
        vesting_count: u8,
        lockDeposit: bool,
        lockDistribute: bool,
        lockWithdraw: bool,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        amount_donated: u64,
    }

    struct Deposit has store {
        user: address,
        amount: u64,
    }

    struct FundOwnerCap has key {
        id: 0x2::object::UID,
        launchpad_id: 0x2::object::ID,
    }

    public entry fun change_softcap(arg0: &FundOwnerCap, arg1: &mut Launchpad, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(&arg0.launchpad_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        arg1.soft_cap = arg2;
    }

    public entry fun create_launchpad(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Launchpad{
            id             : v0,
            soft_cap       : arg0,
            start_time     : arg1,
            end_time       : arg2,
            total_tokens   : arg3,
            deposits       : 0x1::vector::empty<Deposit>(),
            raised         : 0x2::balance::zero<0x2::sui::SUI>(),
            vesting_count  : 1,
            lockDeposit    : false,
            lockDistribute : true,
            lockWithdraw   : true,
        };
        let v2 = FundOwnerCap{
            id           : 0x2::object::new(arg4),
            launchpad_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<FundOwnerCap>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::share_object<Launchpad>(v1);
    }

    public entry fun deposit(arg0: &mut Launchpad, arg1: address, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg4);
        assert!(!arg0.lockDeposit, 9);
        assert!(arg3 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg5)));
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v2 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
            if (v2.user == arg1) {
                v2.amount = v2.amount + arg3;
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        if (!v1) {
            let v3 = Deposit{
                user   : arg1,
                amount : arg3,
            };
            0x1::vector::push_back<Deposit>(&mut arg0.deposits, v3);
        };
        let v4 = Receipt{
            id             : 0x2::object::new(arg5),
            amount_donated : arg3,
        };
        0x2::transfer::public_transfer<Receipt>(v4, 0x2::tx_context::sender(arg5));
    }

    public entry fun depositKey(arg0: &FundOwnerCap, arg1: &mut Launchpad, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(&arg0.launchpad_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        arg1.lockDeposit = arg2;
    }

    public entry fun withdrawKey(arg0: &FundOwnerCap, arg1: &mut Launchpad, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(&arg0.launchpad_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        arg1.lockWithdraw = arg2;
    }

    public entry fun withdraw_funds(arg0: &FundOwnerCap, arg1: &mut Launchpad, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(&arg0.launchpad_id == 0x2::object::uid_as_inner(&arg1.id), 0);
        assert!(!arg1.lockWithdraw, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.raised, 0x2::balance::value<0x2::sui::SUI>(&arg1.raised), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

