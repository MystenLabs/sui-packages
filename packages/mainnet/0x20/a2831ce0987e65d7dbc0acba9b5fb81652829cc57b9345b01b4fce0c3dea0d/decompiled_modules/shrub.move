module 0x20a2831ce0987e65d7dbc0acba9b5fb81652829cc57b9345b01b4fce0c3dea0d::shrub {
    struct SHRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUB>(arg0, 6, b"SHRUB", b"Elon Hedgehog", b"Meet Elon Musk Hedgehog - SHRUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHRUB_5ab12afad1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

