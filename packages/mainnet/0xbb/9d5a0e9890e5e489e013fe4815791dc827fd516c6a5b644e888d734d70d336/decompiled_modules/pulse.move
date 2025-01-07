module 0xbb9d5a0e9890e5e489e013fe4815791dc827fd516c6a5b644e888d734d70d336::pulse {
    struct PULSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULSE>(arg0, 6, b"Pulse", b"Pulse on sui", b"$Pulse is the ultimate burnout sponge memecoinrelatable, hilarious, and ready to absorb memes, dreams, and streams of gains. No stress, just Pulse it up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_7f2f779a20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

