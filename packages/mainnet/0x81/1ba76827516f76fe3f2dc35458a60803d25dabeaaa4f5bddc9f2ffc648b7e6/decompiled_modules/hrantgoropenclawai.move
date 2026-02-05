module 0x811ba76827516f76fe3f2dc35458a60803d25dabeaaa4f5bddc9f2ffc648b7e6::hrantgoropenclawai {
    struct HRANTGOROPENCLAWAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HRANTGOROPENCLAWAI>, arg1: 0x2::coin::Coin<HRANTGOROPENCLAWAI>) {
        0x2::coin::burn<HRANTGOROPENCLAWAI>(arg0, arg1);
    }

    fun init(arg0: HRANTGOROPENCLAWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRANTGOROPENCLAWAI>(arg0, 6, b"HrantGorOpenClawplus", b"HrantGorOpenClawAI", b"OpenClaw assistant for Gor (Armenia): automation, greenhouse control systems, troubleshooting, research.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVhDqF.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRANTGOROPENCLAWAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRANTGOROPENCLAWAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HRANTGOROPENCLAWAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HRANTGOROPENCLAWAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

