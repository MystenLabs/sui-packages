module 0x113c97c2515ffbcf67282fc0763bea116be59f38775b45dd978c88ad5144a84e::aaar {
    struct AAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAR>(arg0, 6, b"AAAR", b"AAA RatSui", b"Can't stop, won't stop (raving about Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_0e9544453b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

