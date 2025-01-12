module 0x1b32b449015c76d2f6d6fb50fbd8db4ef9a8e9cef6859325ce1af3bb5f0b7994::hypeli {
    struct HYPELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPELI>(arg0, 6, b"HYPELI", b"Hype", b"Hyperliquid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d544a9ca-129e-4f00-82d5-9dbbadf388d9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPELI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPELI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

