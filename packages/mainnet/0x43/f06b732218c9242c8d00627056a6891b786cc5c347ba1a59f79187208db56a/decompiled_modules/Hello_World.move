module 0x43f06b732218c9242c8d00627056a6891b786cc5c347ba1a59f79187208db56a::Hello_World {
    struct HELLO_WORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO_WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_WORLD>(arg0, 9, b"HELLOWORLD", b"Hello World", b"hello bretheren. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/0f814314-e171-4a41-ba4d-e16a60aa769c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_WORLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO_WORLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

