module 0x8500260216a65b2592de30a6860119362e027a23660dca3b8199ddb6442ef6f8::jellyfish {
    struct JELLYFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYFISH>(arg0, 6, b"Jellyfish", b"jellyfish", b"only a jellyfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_f7fe88e706.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLYFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

