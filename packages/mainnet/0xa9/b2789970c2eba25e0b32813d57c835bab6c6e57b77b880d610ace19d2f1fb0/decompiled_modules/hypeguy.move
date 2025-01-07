module 0xa9b2789970c2eba25e0b32813d57c835bab6c6e57b77b880d610ace19d2f1fb0::hypeguy {
    struct HYPEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPEGUY>(arg0, 6, b"HYPEGUY", b"HYPEGUY ON SUI", b"HypeGuy is an innovative meme project inspired by the laid-back essence of the \"Chill Guy\" meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01_2_3ce0e55322.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPEGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPEGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

