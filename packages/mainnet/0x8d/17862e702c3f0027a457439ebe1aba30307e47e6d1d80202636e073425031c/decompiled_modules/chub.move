module 0x8d17862e702c3f0027a457439ebe1aba30307e47e6d1d80202636e073425031c::chub {
    struct CHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUB>(arg0, 6, b"CHUB", b"CHUB THE EEL", b"Girthiest Eel in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eel_602d5aa2df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

