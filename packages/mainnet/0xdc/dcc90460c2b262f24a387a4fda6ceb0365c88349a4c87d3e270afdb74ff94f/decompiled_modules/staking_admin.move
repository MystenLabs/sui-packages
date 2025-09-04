module 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::staking_admin {
    struct StakingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct STAKING_ADMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKING_ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<StakingAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

