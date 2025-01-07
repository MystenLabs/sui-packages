module 0x6fab390b7b704a1a43c4380d574002577751665485a2640729cb0a299f28ceb3::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"Fox Matt Furie", b"The time has come for $FOX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_c89379b36a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

