module 0x4ab096b87692926524eedb2a8de9479bc734c2a1a911f4e4db6101fdc0a192af::mozuku {
    struct MOZUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZUKU>(arg0, 6, b"MOZUKU", b"Mozuku on sui", b"The real name of DOGE on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/motsex_70e043da9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

