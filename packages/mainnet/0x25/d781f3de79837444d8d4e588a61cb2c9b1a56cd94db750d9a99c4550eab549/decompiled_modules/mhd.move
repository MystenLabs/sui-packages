module 0x25d781f3de79837444d8d4e588a61cb2c9b1a56cd94db750d9a99c4550eab549::mhd {
    struct MHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHD>(arg0, 6, b"MHD", b"Musk have Dolphin", b"We Musk have Dolphin!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5879_6eb18b2849.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

