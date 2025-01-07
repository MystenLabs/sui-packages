module 0x967dfbc83d224e3f8e7382104ab01403d00f8f654da1dd59c47e201c9f49149::lata {
    struct LATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LATA>(arg0, 9, b"lata", b"lata", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LATA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LATA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

