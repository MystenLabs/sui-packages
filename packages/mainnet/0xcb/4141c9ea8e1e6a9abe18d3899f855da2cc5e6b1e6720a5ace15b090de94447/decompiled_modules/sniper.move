module 0xcb4141c9ea8e1e6a9abe18d3899f855da2cc5e6b1e6720a5ace15b090de94447::sniper {
    struct SNIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPER>(arg0, 9, b"Sniper", b"Sniperxyz", b"sniper.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f7ede62a0b8d9c76db9d3543231359d2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNIPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

