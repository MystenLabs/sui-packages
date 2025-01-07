module 0xbc8bfa1a99c8cb19155656c54f788e58a07a2c19b506d3fe02e021750bbe0e8e::suinomics {
    struct SUINOMICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOMICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOMICS>(arg0, 6, b"SUINOMICS", b"SUINOMICS - THE MAGICAL SCIENCE", b"SUINOMICS is the magical science of making money appear, disappear, and sometimes multiply, but mostly just making you wonder where it all went. It's the study", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ava2_2e952a9964.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOMICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOMICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

