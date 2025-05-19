module 0x7eb0057ae5ef3ebb9d7d2fce16f18092222279b3c9c70b71f5af2b50f79ac06a::cikcik {
    struct CIKCIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIKCIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIKCIK>(arg0, 6, b"CikCik", b"The CikCik", b"Little cikci, smol, cute... but uh oh, very ouchie ducky!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiasu6tor5jkkc2ojitkqx4zqzmd5rpta3yjbnrk5o4swvtsi7trme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIKCIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIKCIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

