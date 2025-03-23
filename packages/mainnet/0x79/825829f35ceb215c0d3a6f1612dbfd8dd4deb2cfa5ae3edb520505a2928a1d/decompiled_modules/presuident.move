module 0x79825829f35ceb215c0d3a6f1612dbfd8dd4deb2cfa5ae3edb520505a2928a1d::presuident {
    struct PRESUIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESUIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESUIDENT>(arg0, 6, b"PRESUIDENT", b"MR. PRESUIDENT", b"Presuident Trump makes SUI great again. Agree? Buy this fantoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vibes_749cd9562b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESUIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRESUIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

