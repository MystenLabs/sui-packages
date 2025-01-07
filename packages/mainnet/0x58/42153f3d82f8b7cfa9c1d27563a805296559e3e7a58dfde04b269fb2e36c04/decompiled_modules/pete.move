module 0x5842153f3d82f8b7cfa9c1d27563a805296559e3e7a58dfde04b269fb2e36c04::pete {
    struct PETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETE>(arg0, 6, b"PETE", b"PEPE TERMINAL", x"50455045205445524d494e414c205665722e20302e302e310a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kfkj_Jkr_C_400x400_fb2843b8e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

