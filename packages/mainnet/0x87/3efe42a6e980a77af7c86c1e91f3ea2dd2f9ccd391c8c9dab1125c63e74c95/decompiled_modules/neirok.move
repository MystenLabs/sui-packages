module 0x873efe42a6e980a77af7c86c1e91f3ea2dd2f9ccd391c8c9dab1125c63e74c95::neirok {
    struct NEIROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROK>(arg0, 6, b"NEIROK", b"Neiro Grok", b"Neiro Grok aint just a coin; its a whole vibe. Neiros already made waves, winning over the crowd with its chill yet powerful energy. Grok, on the flip side, is all about getting deep and mastering the game. Put em together, and youve got Neiro Grokthe crypto powerhouse thats ready to take over.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Profpic_neirok_a41db4e514.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

