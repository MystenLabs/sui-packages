module 0xfb2f0c67ed792f5bdd4ec6c4a4123fc4bb9d008aaba9fc887294b09b0f136a2a::rcat {
    struct RCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCAT>(arg0, 6, b"RCat", b"rainbow cat", b"One of World's most famous cats, Nyan cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1491728888565_pic_8d6dbd074e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

