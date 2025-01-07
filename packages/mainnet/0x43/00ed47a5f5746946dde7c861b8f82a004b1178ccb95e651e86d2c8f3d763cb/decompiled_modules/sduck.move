module 0x4300ed47a5f5746946dde7c861b8f82a004b1178ccb95e651e86d2c8f3d763cb::sduck {
    struct SDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUCK>(arg0, 6, b"SDUCK", b"SUIDUCK", b"$SDUCK on the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ducklogo_01_2_fdf8389e78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

