module 0xed16b02261acd29ca105f285eae969458c46bfad7f7c16dd5d7156ebdc2bc966::arca {
    struct ARCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCA>(arg0, 6, b"ARCA", b"ArcheriumAI", x"466c61736820437261736865732c2046617374204f70706f7274756e6974696573204e617669676174696e672043727970746f20566f6c6174696c697479207769746820507265636973696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737728607330.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

