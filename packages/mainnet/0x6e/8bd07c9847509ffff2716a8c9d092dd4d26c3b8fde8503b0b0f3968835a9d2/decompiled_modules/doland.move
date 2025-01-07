module 0x6e8bd07c9847509ffff2716a8c9d092dd4d26c3b8fde8503b0b0f3968835a9d2::doland {
    struct DOLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAND>(arg0, 6, b"DOLAND", b"DOLAND the DUCK", b"Fuckin Duck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/41htcw_c9d4717191.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

