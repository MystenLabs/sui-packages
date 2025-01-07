module 0x23c5df47a99374103725dbfe102a79a2a4d149b2029ce33922fc9492b181592d::suinomics {
    struct SUINOMICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOMICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOMICS>(arg0, 6, b"SUINOMICS", b"SUINOMICS - SUI Economics", b"SUINOMICS is the magical science of making money appear, disappear, and sometimes multiply, but mostly just making you wonder where it all went. It's the study", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ava2_ffe5818cfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOMICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOMICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

