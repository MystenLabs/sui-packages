module 0xca4753774462f96957be78eb8ddfade8d58d5a8b955f8adbdfc7692cebe0737a::saaa {
    struct SAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAAA>(arg0, 6, b"SAAA", b"Saaagull", x"54686520766972616c2073637265616d696e672073656167756c6c206d656d652c206e6f77206f6e20535549206173205361616167756c6c2e0a0a414141414141414141414141414141414141414141414141414141", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_7_ebb91af66e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

