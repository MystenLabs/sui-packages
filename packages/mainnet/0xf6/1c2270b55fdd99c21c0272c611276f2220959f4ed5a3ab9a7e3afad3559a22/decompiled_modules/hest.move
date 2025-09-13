module 0xf61c2270b55fdd99c21c0272c611276f2220959f4ed5a3ab9a7e3afad3559a22::hest {
    struct HEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEST>(arg0, 9, b"HEST", b"Hestya Coin", b"Just one more shitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.tusky.io/api/proxy/download/e144c484-eb7c-4dc2-a726-1bfb7057a3bb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEST>>(v2, @0xd3bb50145e5f8ed090e9857b643dfb924e0b927f512ac5d6c861dc382f1d693c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

