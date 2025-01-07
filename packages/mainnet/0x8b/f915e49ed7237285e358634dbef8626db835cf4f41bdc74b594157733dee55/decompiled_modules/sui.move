module 0x8bf915e49ed7237285e358634dbef8626db835cf4f41bdc74b594157733dee55::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"suite suite", b"liofe is good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SUITE_d15582b9af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

