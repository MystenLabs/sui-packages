module 0xd316348831f19398f4e3f9793ade7653d83a3b659f1f217719b35b32b70e8221::tjc {
    struct TJC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TJC>(arg0, 6, b"TJC", b"tjcore by SuiAI", b"haha wode guaiguai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/44733cc7_7f30_4fe1_9e7d_ad743c17c322_7759e2d35a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TJC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

