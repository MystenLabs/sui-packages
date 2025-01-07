module 0xee2d9812750910d1630ca949a7180580a94ccb83a5921934a455cc784ca29570::dgkn {
    struct DGKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGKN>(arg0, 6, b"DGKN", b"DOGUKAN", b"turbos.fun's first condom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731238207035.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGKN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGKN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

