module 0x4b2bdce1c1db6235a2b21ea50b5b57093fe94ad0a534357caa01c574b08c99d5::dogwifhat {
    struct DOGWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFHAT>(arg0, 6, b"DOGWIFHAT", b"Dogwifhat", b"A dog, but wif hat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.coindesk.com/resizer/UzxQ2FepGGlH5I5fVrQcy19s3Wc=/567x319/filters:quality(80):format(jpg)/cloudfront-us-east-1.images.arcpublishing.com/coindesk/AHRVBRW5B5F4FK7AHW32U2FGVY.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGWIFHAT>(&mut v2, 100000001000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFHAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

