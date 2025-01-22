module 0xf5530ad2e2116eafb59c4330c1f0f24a21d2e13a7c0053da21c53c87d349c7b0::dogex {
    struct DOGEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEX>(arg0, 6, b"DOGEX", b"Departemen Of Government Efficiency by SuiAI", b"Departemen Of Government Efficiency | D.O.G.E.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0a053ad8_798a_4cc7_adf1_95becbb72123_1_1_1_1a4f471bd2_98dff9b627.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

