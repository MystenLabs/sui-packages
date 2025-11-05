module 0x517681693052dadca8ab219f87b74bfbc5abda2b457973dccb7909c07a915cd3::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 6, b"Lord", b"Test", b"LORD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LORD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

