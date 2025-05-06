module 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::area {
    struct Account has copy, drop, store {
        version: u64,
        digi: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable,
        kaka: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable,
        dada: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable,
        daka: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable,
    }

    public fun borrow_dada(arg0: &Account) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &arg0.dada
    }

    public fun borrow_dada_mut(arg0: &mut Account) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &mut arg0.dada
    }

    public fun borrow_daka(arg0: &Account) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &arg0.daka
    }

    public fun borrow_daka_mut(arg0: &mut Account) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &mut arg0.daka
    }

    public fun borrow_digi(arg0: &Account) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &arg0.digi
    }

    public fun borrow_digi_mut(arg0: &mut Account) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::Lockable {
        &mut arg0.digi
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
            digi    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::new_lockable(),
            kaka    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::new_lockable(),
            dada    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::new_lockable(),
            daka    : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::new_lockable(),
        }
    }

    public fun reward(arg0: &mut Account, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = &mut arg0.digi;
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_locked(v0, arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::unlock(v0, arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::increase_locked(&mut arg0.daka, arg1);
    }

    public fun withdraw(arg0: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg1: &mut 0x2::coin::TreasuryCap<0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::DIGI>, arg2: &mut Account, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2.digi;
        let v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::available_balance(v0);
        if (v1 == 0) {
            return
        };
        0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi::mint<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::EventTip>(arg0, arg1, v1, arg3, 8001, 0x1::string::utf8(b"daka.area.reward"), 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::new_event_tip(0x1::string::utf8(b"")), arg4);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::lockable::decrease_available(v0, v1);
    }

    // decompiled from Move bytecode v6
}

