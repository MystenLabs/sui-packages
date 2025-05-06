module 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::member {
    struct Account has copy, drop, store {
        version: u64,
        kaka: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable,
        daka: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable,
    }

    public fun borrow_daka(arg0: &Account) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &arg0.daka
    }

    public fun borrow_daka_mut(arg0: &mut Account) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &mut arg0.daka
    }

    public fun borrow_kaka(arg0: &Account) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &arg0.kaka
    }

    public fun borrow_kaka_mut(arg0: &mut Account) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &mut arg0.kaka
    }

    public fun new_account() : Account {
        Account{
            version : 1,
            kaka    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::new_lockable(),
            daka    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::new_lockable(),
        }
    }

    public fun reward(arg0: &mut Account, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils::ratio_calc(arg1, 1000);
        let v1 = &mut arg0.kaka;
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_locked(v1, v0);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::unlock(v1, v0);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_locked(&mut arg0.daka, v0);
    }

    public fun withdraw(arg0: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::kaka::KAKA>, arg1: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::kaka::KAKA>, arg2: &mut Account, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2.kaka;
        let v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::available_balance(v0);
        if (v1 == 0) {
            return
        };
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::kaka::mint<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::EventTip>(arg0, arg1, v1, arg3, 8008, 0x1::string::utf8(b"daka.member.reward"), 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::new_event_tip(0x1::string::utf8(b"")), arg4);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::decrease_available(v0, v1);
    }

    // decompiled from Move bytecode v6
}

