module 0xe335d4ac808f77f5b63c2abd519e12223792d88e0df3013cbe65d1d0513bb255::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 9, b"XSUI", b"XSUI", b"XSUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/nfttokenasa/image/upload/v1744384279/rurfmqxmw6labubioufx.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XSUI>(&mut v2, 790000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

