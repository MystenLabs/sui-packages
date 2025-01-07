module 0x69e900e3b163a15d01f3446f9afd54025a87dd41fbf3cfc67060cff3b89b05bb::kuku {
    struct KUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKU>(arg0, 6, b"KUKU", b"KUKUcat", b"$KUKUcat is the ultimate \"$KIKIcat Killer,\" a 100% community-driven memecoin built in SUI Network to challenge the dominance of whale-controlled, corporate-backed projects like $KIKI. Unlike its centralized rivals, $KUKU thrives on grassroots support", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736052232137.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

