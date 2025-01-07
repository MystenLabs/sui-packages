module 0x67055c07825dbd9dda27c6ae3a59634d96bad6bddea2a81ec6658e0de5613744::fitty {
    struct FITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FITTY>(arg0, 6, b"FITTY", b"Fish Kitty", x"64696420796f7520657665722074616c6b0a746f206120666973686b697474656e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040923_44eb53e720.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

