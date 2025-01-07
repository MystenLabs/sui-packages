module 0x1ae67bbab92ecddf993945763a1ee2713bbf0adf895757c774eca553afccf49c::suisun {
    struct SUISUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUN>(arg0, 6, b"SUISUN", b"SuISUN", b"SUN is everywhere and on SUI too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1727_355617ad1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

