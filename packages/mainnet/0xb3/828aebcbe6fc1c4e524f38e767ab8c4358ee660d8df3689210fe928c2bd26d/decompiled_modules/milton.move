module 0xb3828aebcbe6fc1c4e524f38e767ab8c4358ee660d8df3689210fe928c2bd26d::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 6, b"Milton", b"Hurricane Suilton", b"I can't wait to make landfall.....it's going to be SUIPER!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_134648_b379fdd148.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

