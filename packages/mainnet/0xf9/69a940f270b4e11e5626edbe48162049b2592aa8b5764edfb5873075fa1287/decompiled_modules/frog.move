module 0xf969a940f270b4e11e5626edbe48162049b2592aa8b5764edfb5873075fa1287::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"FROG ON SUI", x"5468652066756e6e69657374206d656d636f696e206f6e207468652053554920626c6f636b636861696e2069732046524f472120200a0a546869732066726f67206e6f74206f6e6c7920717561636b732c2062757420616c736f206a756d707320737472616967687420746f20746865206d6f6f6e2c206c656176696e6720616c6c206f62737461636c657320626568696e642e2049742773206e6f74206a757374206120636f696e2c206974277320612077686f6c65206b77612d717561207265766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/2024_09_24_21_27_14_99f9f959b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

