module 0xf31ede5550eaf0b549e31088a20fd0c750a9376e302986cf8fd02e003798a847::suinazi {
    struct SUINAZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAZI>(arg0, 6, b"SUINAZI", b"No SUI for you", b"you pump the token or no SUI for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Soup_Nazi_dc7e1e930b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

