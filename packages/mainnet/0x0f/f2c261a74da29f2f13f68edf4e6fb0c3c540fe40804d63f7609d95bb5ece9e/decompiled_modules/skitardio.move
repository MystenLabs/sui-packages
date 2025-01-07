module 0xff2c261a74da29f2f13f68edf4e6fb0c3c540fe40804d63f7609d95bb5ece9e::skitardio {
    struct SKITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITARDIO>(arg0, 6, b"SKITARDIO", b"SKITARDIO SUI", b"Ski Tardio Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6631_895fb5bef3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

