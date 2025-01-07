module 0x671b1fa2a124f5be8bdae8b91ee711462c5d9e31bda232e70fd9607b523c88::scallop_af_sui {
    struct SCALLOP_AF_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_AF_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_AF_SUI>(arg0, 9, b"sAfSUI", b"sAfSUI", b"Scallop interest-bearing token for afSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mnxwwxcwwduyl47fxpernims2yrg3ugsh2vgeeebxldc7iyl4hoa.arweave.net/Y29rXFaw6YXz5bvJFqGS1iJt0NI-qmIQgbrGL6ML4dw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_AF_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_AF_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

