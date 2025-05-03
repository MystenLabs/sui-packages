module 0x45fbeb9864924ef0907ff930a41eb29f876bc7acdebadf81e35696ee1cf5d262::kymi_sui {
    struct KYMI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYMI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYMI_SUI>(arg0, 9, b"kymiSUI", b"Kymi Staked SUI", b"Liquid staking for the beautiful island of Euboea in Greece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/8297b8f2-700e-4028-aac3-0b1079265648/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYMI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYMI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

