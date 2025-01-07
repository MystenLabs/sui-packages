module 0xc7b40ae7fa1472c9ac4c713318df53e1e129148a0c8718ac62e077236a3ace53::sutrump {
    struct SUTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUTRUMP>(arg0, 6, b"SUTRUMP", b"SU TRUMP", b"SUI TRUMP, folks, is the most tremendous crypto out there. Were talking real strength, real power, and a community of WINNERS. Its not just a coin; its a movement. SUI TRUMP is all about solid innovation, unstoppable momentum, and the kind of gains thatll make your head spin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/120e0as0dpasd_545984499e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

