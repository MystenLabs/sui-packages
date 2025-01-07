module 0xf4023a8fa17e8e8564bd2ce3dc6dcbf9dc3e5d2e4146e693f98ae2a6e8ca03de::suinomics {
    struct SUINOMICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOMICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOMICS>(arg0, 6, b"SUINOMICS", b"SUINOMICS - Sui Economics", b"SUINOMICS is the magical science of making money appear, disappear, and sometimes multiply, but mostly just making you wonder where it all went.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ava2_00e8189e0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOMICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOMICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

