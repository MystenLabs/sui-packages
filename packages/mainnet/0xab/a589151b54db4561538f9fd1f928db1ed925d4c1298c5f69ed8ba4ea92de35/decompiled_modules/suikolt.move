module 0xaba589151b54db4561538f9fd1f928db1ed925d4c1298c5f69ed8ba4ea92de35::suikolt {
    struct SUIKOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOLT>(arg0, 6, b"SUIKOLT", b"SuiKolt TOken", b"BLUE KOLT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Kolt_66a03ebc22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

