module 0x5baf25ce01f4680ee429d55a76aee8756b3bb079e77f942ebebc1ac18497891::b_scallop_sui {
    struct B_SCALLOP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SCALLOP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SCALLOP_SUI>(arg0, 9, b"bsSUI", b"bToken sSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SCALLOP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SCALLOP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

