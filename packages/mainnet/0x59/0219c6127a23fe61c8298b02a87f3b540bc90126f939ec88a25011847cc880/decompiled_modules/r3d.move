module 0x590219c6127a23fe61c8298b02a87f3b540bc90126f939ec88a25011847cc880::r3d {
    struct R3D has drop {
        dummy_field: bool,
    }

    fun init(arg0: R3D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R3D>(arg0, 6, b"R3d", x"523364e280a2c3987262", x"c3866e69676dc3a62e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735339322373.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R3D>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R3D>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

