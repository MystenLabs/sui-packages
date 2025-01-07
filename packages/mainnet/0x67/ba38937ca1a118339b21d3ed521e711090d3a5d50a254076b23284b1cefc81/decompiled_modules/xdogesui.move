module 0x67ba38937ca1a118339b21d3ed521e711090d3a5d50a254076b23284b1cefc81::xdogesui {
    struct XDOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDOGESUI>(arg0, 6, b"Xdogesui", b"X doge on sui", b"X doge on sui blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000908423_297bf5de90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

