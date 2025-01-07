module 0x56d7e4b6b7994964a5bbf5284e02d6b83080784fc82c942b9502ce38503def68::yelu {
    struct YELU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YELU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YELU>(arg0, 6, b"Yelu", b"Yale", b"Yale on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1912_dfc73c6319.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YELU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YELU>>(v1);
    }

    // decompiled from Move bytecode v6
}

