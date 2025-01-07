module 0x4ef81fc34596da7c0a28b5e909478c2a38e64ec3161b4265dd8ab98ce165df60::suillama {
    struct SUILLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLAMA>(arg0, 6, b"SUILLAMA", b"SuiLlama", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suillama_cf048f530c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

