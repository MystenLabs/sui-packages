module 0x1371b66bf1a959e0386334d5ecb2f00413ef236e5c0a9b4514f3980cbd23e4c2::fwogmi {
    struct FWOGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGMI>(arg0, 6, b"FWOGMI", b"FWOGMI SUI", b"fwogmi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bgbg_c62b56723c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

