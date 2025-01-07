module 0x874ea6d9ee4ad33bfd9f7705e436c342c05707ecba1d6ced3798ace84956d87::suiharambe {
    struct SUIHARAMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHARAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHARAMBE>(arg0, 6, b"SUIHARAMBE", b"HARAMBE", x"484152414d4245204e455645522044494553200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3510_19f83bd008.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHARAMBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHARAMBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

