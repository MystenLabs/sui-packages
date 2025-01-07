module 0x34684e7e4159a49c5bf02f6ff79715ec9e5bea7e2729a4c06a4c95fa004e7467::slots {
    struct Slots has copy, drop, store {
        dummy_field: bool,
    }

    struct SlotsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: 0x2::coin::Coin<T0>) {
        let v0 = Slots{dummy_field: false};
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, Slots>(v0, arg0, arg1);
    }

    public fun deposit_bal<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: 0x2::balance::Balance<T0>) {
        let v0 = Slots{dummy_field: false};
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::join<T0, Slots>(v0, arg0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SlotsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SlotsAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw_funds<T0>(arg0: &SlotsAdminCap, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = Slots{dummy_field: false};
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::take<T0, Slots>(v0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

