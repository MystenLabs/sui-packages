module 0x16224e3c288d1fe9c2d8627d4501653879e2c02aaf3b3744bcb226d4e6fe7d55::Bronson {
    struct BRONSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRONSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRONSON>(arg0, 9, b"BRONSON", b"Bronson", b"idgaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0P3pv3WIAAt6zH?format=jpg&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRONSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRONSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

