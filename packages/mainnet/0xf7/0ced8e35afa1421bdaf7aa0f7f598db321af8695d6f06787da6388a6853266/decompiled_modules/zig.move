module 0xf70ced8e35afa1421bdaf7aa0f7f598db321af8695d6f06787da6388a6853266::zig {
    struct ZIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIG>(arg0, 8, b"ZIG", b"ZIGGURAT", b"ZIGGURAT  on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/cefef157-f335-466e-aef8-2b4c5775cce0.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZIG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

