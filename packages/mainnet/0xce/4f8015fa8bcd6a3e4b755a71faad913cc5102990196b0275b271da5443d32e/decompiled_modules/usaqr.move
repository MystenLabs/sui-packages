module 0xce4f8015fa8bcd6a3e4b755a71faad913cc5102990196b0275b271da5443d32e::usaqr {
    struct USAQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USAQR>(arg0, 9, b"USAQR", b"USA QR COIN", b"USA QUICK-RESPONSE CODE COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USAQR>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAQR>>(v2, @0x8fb45c072d04b0e3f0fd3f7c09f8e834549b5312ffe7be129dee6a07738491b9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USAQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

