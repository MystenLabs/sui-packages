module 0x963e2fb2f5ac2fb37e05d6cb5de1852e9df7f9c6b779afbe937a23eee339f3ac::rdx {
    struct RDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDX>(arg0, 6, b"RDX", b"Rendex", b"Rendex Defi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752542429299.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

