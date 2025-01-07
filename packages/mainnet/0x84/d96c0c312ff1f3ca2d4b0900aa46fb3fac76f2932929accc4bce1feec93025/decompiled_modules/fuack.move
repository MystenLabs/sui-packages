module 0x84d96c0c312ff1f3ca2d4b0900aa46fb3fac76f2932929accc4bce1feec93025::fuack {
    struct FUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUACK>(arg0, 6, b"FUACK", b"Fuack the Duck", b"we do a little $fuack around and find out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055335_83799e2738.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

