module 0x33144afdab1a7a1ef04cc2a095d4d13dbf55666115478cb6a9e97563f4b1a1a3::cokkie {
    struct COKKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKKIE>(arg0, 6, b"COKKIE", b"Cokkie token usdt", b"Description  of Cokkie token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d3cc51bf-5695-4ed0-a1f7-44bf8914f6b9.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COKKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKKIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

