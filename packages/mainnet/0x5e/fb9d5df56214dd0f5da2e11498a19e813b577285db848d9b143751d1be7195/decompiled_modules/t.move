module 0x5efb9d5df56214dd0f5da2e11498a19e813b577285db848d9b143751d1be7195::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"TEST", b"TESTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/0e436f4e-c9c8-4a30-bd44-2a96bc59f2f1.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

