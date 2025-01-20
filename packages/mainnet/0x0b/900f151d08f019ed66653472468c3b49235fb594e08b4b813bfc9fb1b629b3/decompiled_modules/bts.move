module 0xb900f151d08f019ed66653472468c3b49235fb594e08b4b813bfc9fb1b629b3::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 6, b"BTS", b"BitSense", b"Real-time cryptocurrency news & market intelligence. Breaking updates, expert analysis, and blockchain insights. Trusted by crypto traders & investors worldwide. . https://bitsense.news", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0bdd8f44c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

