module 0xc27b24366553faab8ab0db7b4ac5c2fc14f5497aae0fce8731f76d037aaf489c::huan {
    struct HUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUAN>(arg0, 6, b"HUAN", b"Don Huan Chihua", b"Slippin' Huan Pup on the Sui chain is here to make some badass moves. Who the hell are you? You know. You all know exactly who I am. Say my name. Do what? I don't... I don't have a damn clue who the hell you are. Yeah, you do. I'm the cook. I'm the man who killed Shiba Dog. Bullshit. Cartel got Shiba. Are you sure? That's right. Now, say my name. HUAN. You're goddamn right.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Jizw_C_Xo_AA_Xl7_O_138b41a3b5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

