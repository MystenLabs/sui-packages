module 0xa814d57872100b47a8a13f37b9852d7afc5676e4963d09472e99f1c9ee6800df::usdccel {
    struct USDCCEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDCCEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDCCEL>(arg0, 9, b"USDCcel", b"USD Coin", b"Celear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDCCEL>(&mut v2, 17629292000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDCCEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDCCEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

