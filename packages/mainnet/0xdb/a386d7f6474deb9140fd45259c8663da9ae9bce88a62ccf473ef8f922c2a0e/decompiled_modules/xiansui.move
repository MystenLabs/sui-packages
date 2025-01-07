module 0xdba386d7f6474deb9140fd45259c8663da9ae9bce88a62ccf473ef8f922c2a0e::xiansui {
    struct XIANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIANSUI>(arg0, 6, b"XIANSUI", b"XIANSUI ON SUI", b"XIAN SUI PIE XUE HOE PUE HAK TWAH XIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_946f6b5006.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

