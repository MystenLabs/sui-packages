module 0xefb516c4efe6170a25115295e3b0f43d6bada5f04be1caa630f7ff15abad4990::chew {
    struct CHEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEW>(arg0, 6, b"Chew", b"Chewy", b"Meet Chewy, One of Evan Changs beloved dog, the founder of the sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/73460e6e102919ce9a2f1b392798914b_8129913e72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

