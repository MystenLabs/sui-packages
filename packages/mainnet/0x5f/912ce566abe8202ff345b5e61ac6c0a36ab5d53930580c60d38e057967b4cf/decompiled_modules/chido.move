module 0x5f912ce566abe8202ff345b5e61ac6c0a36ab5d53930580c60d38e057967b4cf::chido {
    struct CHIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIDO>(arg0, 6, b"CHIDO", b"Sui Chido", x"4368696e65736520446f6765206f6e205375692e2041206d656d6520636f696e206d61646520666f72204368696e657365210a546865206669727374204368696e65736520646f67206f6e205375692e2024434849444f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_11_56_50_f7cc8a8b3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

