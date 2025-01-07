module 0x8aa924114d8ad92a7c6454f799cf0b2cab7967a551ce205cea5f50189f74ee13::tokyo {
    struct TOKYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKYO>(arg0, 9, b"Tokyo", b"Tokyo", b"Tokyo Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKYO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKYO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

