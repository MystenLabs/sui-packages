module 0x9419bb82182fe74cfdfaf17f5ff78bed519ae66cc1c4d0758d1bbeb439be04d4::buc {
    struct BUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUC>(arg0, 6, b"BUC", b"buc", b"a deer on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/buc_sui_dd67a9465b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

