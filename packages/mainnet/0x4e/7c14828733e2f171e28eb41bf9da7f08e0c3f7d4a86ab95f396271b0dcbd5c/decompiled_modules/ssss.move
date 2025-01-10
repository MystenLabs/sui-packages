module 0x4e7c14828733e2f171e28eb41bf9da7f08e0c3f7d4a86ab95f396271b0dcbd5c::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SSSS>(arg0, 6, b"SSSS", b"@coreykooo by SuiAI", b"@coreykooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9464a1aa6effe666c1864fe8149e2114_334a61127e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSSS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

