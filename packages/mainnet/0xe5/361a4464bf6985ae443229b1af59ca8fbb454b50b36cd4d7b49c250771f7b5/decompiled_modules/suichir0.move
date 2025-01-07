module 0xe5361a4464bf6985ae443229b1af59ca8fbb454b50b36cd4d7b49c250771f7b5::suichir0 {
    struct SUICHIR0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHIR0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHIR0>(arg0, 6, b"SUICHIR0", b"SUICHIRO", b" Suichiro is all about good vibes, chill times, and smooth transactions. With his surfboard in one paw and a joint in the other, Suichiro surfs through the blockchain, spreading relaxation and decentralization to all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_00_20_22_0f0f99df03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHIR0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHIR0>>(v1);
    }

    // decompiled from Move bytecode v6
}

