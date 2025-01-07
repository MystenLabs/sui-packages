module 0x8f22f5175630bd0c1bb1cf35d52ffa3c5e192e827da9c9556e31106bf2d611b7::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"UncleBonk", x"4d6973736564206f7574206f6e20426f6e6b2c20446f6765206f7220446f6765426f6e6b3f204e6f20776f72726965732120556e636c6520426f6e6b2068617320796f7572206261636b212047657420696e206f6e2074686520616374696f6e20616e64206c657427732073656e642024424f4e4b20736b79726f636b6574696e6720746f20746865206d6f6f6e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_21_20_20_46_4c94954bd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

