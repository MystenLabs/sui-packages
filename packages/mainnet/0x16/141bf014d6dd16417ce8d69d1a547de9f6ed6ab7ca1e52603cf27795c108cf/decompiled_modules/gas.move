module 0x16141bf014d6dd16417ce8d69d1a547de9f6ed6ab7ca1e52603cf27795c108cf::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"GAS", b"GasPump on TON", b"GasPump is a platform where you can create your own coin in 30 seconds. We are waiting for you to join us, start creating your own projects!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5208461906367603938_60f706ae95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

