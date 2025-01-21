module 0x17f5a064bc052ec33f38c0a2112267783c23fe50376a42799fc0eecb3621fb38::vainguard {
    struct VAINGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAINGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VAINGUARD>(arg0, 6, b"VAINGUARD", b"Vainguard by SuiAI", b"Pushing the boundaries of artificial intelligence with quantum computing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/vainguard_dff7a366dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAINGUARD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAINGUARD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

