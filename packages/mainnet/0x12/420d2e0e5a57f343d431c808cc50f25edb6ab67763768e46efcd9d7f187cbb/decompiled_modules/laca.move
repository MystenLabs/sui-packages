module 0x12420d2e0e5a57f343d431c808cc50f25edb6ab67763768e46efcd9d7f187cbb::laca {
    struct LACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LACA>(arg0, 9, b"LACA", b"Laughing Cat", b"LACA (Laughing Cat) pair Launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://creatorset.com/cdn/shop/files/Screenshot_2024-04-24_173231_1114x.png?v=1713973029")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LACA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LACA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

