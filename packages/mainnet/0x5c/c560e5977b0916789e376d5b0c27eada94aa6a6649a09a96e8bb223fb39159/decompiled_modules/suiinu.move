module 0x5cc560e5977b0916789e376d5b0c27eada94aa6a6649a09a96e8bb223fb39159::suiinu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 6, b"SUIINU", b"SuiInu", x"73756920696e75206c697665206f6e2073756920206e6f77210a4974732053554920736561736f6e20616e642074686520776174657220646f672053756920496e752077696c6c206265206c656164696e672069740a0a466f6c6c6f7720583a2068747470733a2f2f782e636f6d2f73756973696e75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_15b948164c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

