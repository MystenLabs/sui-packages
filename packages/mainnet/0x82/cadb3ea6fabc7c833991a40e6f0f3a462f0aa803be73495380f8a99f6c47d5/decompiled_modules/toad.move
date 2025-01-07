module 0x82cadb3ea6fabc7c833991a40e6f0f3a462f0aa803be73495380f8a99f6c47d5::toad {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAD>(arg0, 6, b"TOAD", b"The Obviously Autistic Doge", b"Invest in $TOAD today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_9b3cc63379.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

