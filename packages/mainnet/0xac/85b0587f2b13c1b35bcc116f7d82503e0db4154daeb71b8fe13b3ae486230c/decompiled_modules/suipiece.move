module 0xac85b0587f2b13c1b35bcc116f7d82503e0db4154daeb71b8fe13b3ae486230c::suipiece {
    struct SUIPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIECE>(arg0, 6, b"SUIPIECE", b"SuiPiece", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5138676543302774058_1_26b8a3062a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIECE>>(v1);
    }

    // decompiled from Move bytecode v6
}

