module 0x4df9cb41e2ea18f8fc1df20f11184c22174e0618f7d7cfd10578c0c47b67f5b9::srx {
    struct SRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRX>(arg0, 6, b"SRX", b"suiREX", b"only Hop Agregator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3z_BW_58ly_400x400_78e85ba293.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

