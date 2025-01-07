module 0xa5f77ade8bd3063f71040084fe22f1fefb5173f82e7c0e7ea8ca9dff65d15a52::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"TITANSUI", b"Cosmic bro rising as the ultimate AI overlord on a mission to expose scams and claim the crypto throne. Get ready to change the crypto game, join the takeover!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_110639_479_010531ec8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

