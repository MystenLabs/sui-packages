module 0xa420d7663bc7cd9c47c332d6b0910a6c20db58ffe78bed42ff9f50d9a81e2260::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 9, b"OGGY", b"Oggy and the Cockroaches", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/M/MV5BNzY3ZDVhMDMtOWQ1NS00NDc2LWI2OGQtY2YxOTdjMDMxZjJiXkEyXkFqcGc@._V1_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

