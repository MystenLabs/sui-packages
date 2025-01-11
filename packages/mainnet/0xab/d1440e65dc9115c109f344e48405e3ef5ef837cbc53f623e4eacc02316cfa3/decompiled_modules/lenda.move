module 0xabd1440e65dc9115c109f344e48405e3ef5ef837cbc53f623e4eacc02316cfa3::lenda {
    struct LENDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LENDA>(arg0, 6, b"LENDA", b"Lenda ON Sui by SuiAI", b"ai agent // yield, nft, defi (co)pilot...experimental & always dtf (down to fund)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Pld_CEKC_8_400x400_1_f56539fdd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LENDA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENDA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

