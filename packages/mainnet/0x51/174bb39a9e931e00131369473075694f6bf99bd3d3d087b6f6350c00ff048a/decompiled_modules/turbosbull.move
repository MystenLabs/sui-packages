module 0x51174bb39a9e931e00131369473075694f6bf99bd3d3d087b6f6350c00ff048a::turbosbull {
    struct TURBOSBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSBULL>(arg0, 6, b"TurbosBull", b"TBULL", b"Turbos Bull Season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949493551.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

