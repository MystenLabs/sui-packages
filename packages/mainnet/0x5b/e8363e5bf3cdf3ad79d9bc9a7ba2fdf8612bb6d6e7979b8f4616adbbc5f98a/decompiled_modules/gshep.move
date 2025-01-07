module 0x5be8363e5bf3cdf3ad79d9bc9a7ba2fdf8612bb6d6e7979b8f4616adbbc5f98a::gshep {
    struct GSHEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSHEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSHEP>(arg0, 9, b"GSHEP", b"SHEP", b"0x0204010a20f946b7b059129c15468ee7f43236b175ab866b29cc4641481ac139", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aea68b26-7f7e-4589-852e-c7ee73366e63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSHEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSHEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

