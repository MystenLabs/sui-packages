module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::nineora {
    struct Nineora has store, key {
        id: 0x2::object::UID,
        committee: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee,
    }

    public fun committee_borrow(arg0: &Nineora) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &arg0.committee
    }

    public fun committee_borrow_mut(arg0: &mut Nineora) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &mut arg0.committee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Nineora{
            id        : 0x2::object::new(arg0),
            committee : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::new(arg0),
        };
        0x2::transfer::public_transfer<Nineora>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

