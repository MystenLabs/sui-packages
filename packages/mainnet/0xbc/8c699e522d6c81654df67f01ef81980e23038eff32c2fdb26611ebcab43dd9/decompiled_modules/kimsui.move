module 0xbc8c699e522d6c81654df67f01ef81980e23038eff32c2fdb26611ebcab43dd9::kimsui {
    struct KIMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMSUI>(arg0, 6, b"KIMSUI", b"KIM JONG SUI", x"4b696d204a6f6e67206f6e20535549210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729352400566_23fab54f63_879597e30d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

