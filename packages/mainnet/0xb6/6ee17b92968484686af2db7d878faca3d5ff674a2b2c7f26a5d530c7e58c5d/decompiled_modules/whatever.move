module 0xb66ee17b92968484686af2db7d878faca3d5ff674a2b2c7f26a5d530c7e58c5d::whatever {
    struct WHATEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATEVER>(arg0, 9, b"WHATEVER", b"whatever", b"whatever ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.lovethispic.com/uploaded_images/13568-Whatever.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHATEVER>>(v1);
        0x2::coin::mint_and_transfer<WHATEVER>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WHATEVER>>(v2);
    }

    // decompiled from Move bytecode v6
}

