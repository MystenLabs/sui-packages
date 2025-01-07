module 0x68174e1d00517166721f1077967b83bebc7a2b79a1d1e14f95ecc2bb977c382f::slop {
    struct SLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLOP>(arg0, 6, b"SLOP", b"Sloppy Balls by SuiAI", b"a dog that digs deeper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20240420_155950_de2af2cdc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLOP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

