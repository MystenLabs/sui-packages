module 0xcc7ca3dd5e91ab38a55f44f23ca92ccf4879bbec201f874e7c7c5c7a0cdfdbc4::roby {
    struct ROBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBY>(arg0, 6, b"ROBY", b"Roby", b"Wait! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7163_1ad93e535d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

