module 0xb8e42064e03e925aff9a908db8b75f8249d1785c97194c2f0c813053a2990357::jasuin {
    struct JASUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASUIN>(arg0, 6, b"Jasuin", b"Jasun Voorhes", b"Jasun Voorhes kill on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_3_35c454ebf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JASUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

