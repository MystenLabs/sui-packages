module 0xa5faf979fe49805eab6177f2eb0105ff56ba6921f5e0a2234663f8af374165f4::cbf {
    struct CBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBF>(arg0, 7, b"CBF", b"Cabdi Farax", b"hello May maqlaysa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CBF>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBF>>(v1);
    }

    // decompiled from Move bytecode v6
}

