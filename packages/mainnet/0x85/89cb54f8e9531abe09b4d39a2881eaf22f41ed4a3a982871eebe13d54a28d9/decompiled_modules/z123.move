module 0x8589cb54f8e9531abe09b4d39a2881eaf22f41ed4a3a982871eebe13d54a28d9::z123 {
    struct Z123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z123>(arg0, 9, b"Z123", b"ZEUS", b"Meu amigo pra sempre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f2f7e430e49f79117f3f14df358d3c0fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z123>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z123>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

