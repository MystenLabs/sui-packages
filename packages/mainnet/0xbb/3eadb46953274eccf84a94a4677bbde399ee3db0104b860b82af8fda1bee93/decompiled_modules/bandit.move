module 0xbb3eadb46953274eccf84a94a4677bbde399ee3db0104b860b82af8fda1bee93::bandit {
    struct BANDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDIT>(arg0, 6, b"BANDIT", b"BANDIT (DAD)", b"Everyone's Favorite Dad. Bandit is an archaeologist (he loves to dig up bones) and he does his best to use whatever energy is left after interrupted sleep, work and household chores, to invent and play games with his two little girls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bandit_on_SUI_a2e481c8f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

