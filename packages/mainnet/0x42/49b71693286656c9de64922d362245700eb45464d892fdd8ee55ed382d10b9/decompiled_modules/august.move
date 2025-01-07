module 0x4249b71693286656c9de64922d362245700eb45464d892fdd8ee55ed382d10b9::august {
    struct AUGUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUGUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUGUST>(arg0, 6, b"AUGUST", b"Cat in August", b"I started raising my cat in August, so I named her August!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013122136_5e7d2c74d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUGUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUGUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

