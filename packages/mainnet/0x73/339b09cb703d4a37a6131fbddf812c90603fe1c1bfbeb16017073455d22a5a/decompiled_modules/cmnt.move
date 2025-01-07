module 0x73339b09cb703d4a37a6131fbddf812c90603fe1c1bfbeb16017073455d22a5a::cmnt {
    struct CMNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMNT>(arg0, 6, b"CMNT", b"Community ", x"61206d656d6520636f696e20666f7220616c6c2068756d616e697479f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735081880562.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

