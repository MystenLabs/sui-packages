module 0xfb291ca86dacabc86fb3f7f2bbe882a8aa5c5cb7b332346e791a9f3f51cb8ab2::testury {
    struct TESTURY has drop {
        dummy_field: bool,
    }

    struct Testury has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TesturyAdminCap has key {
        id: 0x2::object::UID,
    }

    fun new(arg0: &mut TESTURY, arg1: &mut 0x2::tx_context::TxContext) : (TesturyAdminCap, Testury) {
        let v0 = TesturyAdminCap{id: 0x2::object::new(arg1)};
        let v1 = Testury{
            id          : 0x2::object::new(arg1),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        (v0, v1)
    }

    fun init(arg0: TESTURY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        let (v1, v2) = new(v0, arg1);
        0x2::transfer::share_object<Testury>(v2);
        0x2::transfer::transfer<TesturyAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun receive_sui_balance(arg0: &mut Testury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun take_from_sui_balance(arg0: &TesturyAdminCap, arg1: &mut Testury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, arg2, arg3)
    }

    public entry fun withdraw_from_sui_balance(arg0: &TesturyAdminCap, arg1: &mut Testury, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(take_from_sui_balance(arg0, arg1, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

