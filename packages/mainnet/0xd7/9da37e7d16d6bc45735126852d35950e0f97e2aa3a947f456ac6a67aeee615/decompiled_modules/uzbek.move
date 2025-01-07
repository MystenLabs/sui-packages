module 0xd79da37e7d16d6bc45735126852d35950e0f97e2aa3a947f456ac6a67aeee615::uzbek {
    struct UZBEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UZBEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UZBEK>(arg0, 6, b"UZBEK", b"Uzbek On Sui", b"The most authentic meme coin in the game on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_uzbek_1_30cfb022e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UZBEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UZBEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

