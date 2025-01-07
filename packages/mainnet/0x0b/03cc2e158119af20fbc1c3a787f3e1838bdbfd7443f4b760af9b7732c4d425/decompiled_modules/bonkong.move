module 0xb03cc2e158119af20fbc1c3a787f3e1838bdbfd7443f4b760af9b7732c4d425::bonkong {
    struct BONKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKONG>(arg0, 6, b"BONKONG", b"Sui Bonk Kong", b"Where Memes and Bananas Collide!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_bc2b1ba942.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

