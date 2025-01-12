module 0xb05d05cf56698c2581f050f0fabfd2c2aacf712ba54b845421726e0a9f291f8f::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"Sui PEPE AI Assistant by SuiAI", b"SUIPEPE FOR AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/24478_b87967c9db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPEPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

