module 0x62ac8b6d33722f8001d7367e0efd06a992fc5e69132c7b4ee1f0020c81318e3b::vainguard {
    struct VAINGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAINGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VAINGUARD>(arg0, 6, b"VAINGUARD", b"Vainguard by SuiAI", b"ainguard is an AI Wealth Manager Agent. Run by Vain & Guard. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/C_Ir_C38_A_400x400_7fa5d87113.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAINGUARD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAINGUARD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

