module 0xf04373885347838a8e1f693a1ecc2cf5c37706de8a2e9a4e5eeec2f3198c98f3::crl {
    struct CRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRL>(arg0, 6, b"CRL", b"Coral", b"pioneering mobile ecosystem for multi-chain environments which was admitted into Binance Labs Incubation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240928_164923_3bf3474674.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

