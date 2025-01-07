module 0x8f22919648738fbd87a7b99ccc21ea65b0fac829136feb6dadae32632e7f1fbb::slipper {
    struct SLIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIPPER>(arg0, 6, b"Slipper", b"Suilipper", b"blue move slipper on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdsdgsdg_b52af917d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

