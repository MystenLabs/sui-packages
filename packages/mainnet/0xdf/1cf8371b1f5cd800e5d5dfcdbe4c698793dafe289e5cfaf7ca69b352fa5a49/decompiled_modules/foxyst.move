module 0xdf1cf8371b1f5cd800e5d5dfcdbe4c698793dafe289e5cfaf7ca69b352fa5a49::foxyst {
    struct FOXYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXYST>(arg0, 9, b"FOXYST", b"Fox Society Token", b"Fox Around The Den", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidfufdlneqqwoct6l3qfhen6zzwf6icvp7eofimvgutcvxdlf65ca.ipfs.dweb.link/FOXSOCIETYTOKEN.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXYST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXYST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXYST>>(v1);
    }

    // decompiled from Move bytecode v6
}

