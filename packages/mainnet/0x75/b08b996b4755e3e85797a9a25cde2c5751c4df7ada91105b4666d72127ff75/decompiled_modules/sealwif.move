module 0x75b08b996b4755e3e85797a9a25cde2c5751c4df7ada91105b4666d72127ff75::sealwif {
    struct SEALWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALWIF>(arg0, 6, b"SEALWIF", b"Seal Wif Hat", b"seal wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/99e5df7cf3fd371c8081d8989162e597_5964f70f2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

