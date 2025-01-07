module 0x10a23f18c97ddad5371ab2865494ada56147bf89c8dab7c1bf4afea1a9a1d040::arena {
    struct ARENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARENA>(arg0, 6, b"ARENA", b"Star Arena", b"ARENA on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731021125502.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARENA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARENA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

