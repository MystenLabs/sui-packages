module 0x1d41c97c34bba345c8c0fb7eeaac69cb341c932401710f090eb77656f573292d::badtrip {
    struct BADTRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADTRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADTRIP>(arg0, 6, b"BADTRIP", b"BAD TRIP", x"54686520667574757265206f662066696e616e63652e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/43b409bfc52e7c45c81629267fe8ec1c_daa64550bb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADTRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADTRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

