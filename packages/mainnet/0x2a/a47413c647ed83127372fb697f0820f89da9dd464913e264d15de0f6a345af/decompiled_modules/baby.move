module 0x2aa47413c647ed83127372fb697f0820f89da9dd464913e264d15de0f6a345af::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 9, b"BABY", b"BABY", b"BABY is flowers of our life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/026/958/085/original/baby-text-design-free-png.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

