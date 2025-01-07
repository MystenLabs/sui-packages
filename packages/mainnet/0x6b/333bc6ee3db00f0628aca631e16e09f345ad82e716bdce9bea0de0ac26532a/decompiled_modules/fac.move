module 0x6b333bc6ee3db00f0628aca631e16e09f345ad82e716bdce9bea0de0ac26532a::fac {
    struct FAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAC>(arg0, 6, b"FAC", b"FACTOS", b"FACTFAC TFACT ACTF ACTFACTFAC TFACT FACTFACT asdasdasdasa sadas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cmmi_9b2754974e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

