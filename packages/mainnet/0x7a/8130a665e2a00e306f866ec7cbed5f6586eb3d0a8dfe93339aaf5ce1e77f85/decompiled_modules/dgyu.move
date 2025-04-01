module 0x7a8130a665e2a00e306f866ec7cbed5f6586eb3d0a8dfe93339aaf5ce1e77f85::dgyu {
    struct DGYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGYU>(arg0, 9, b"DGYU", b"duyi", b"67e8i", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b4399ebf49de6b5dfe7c8a5c6146f3c0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGYU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGYU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

