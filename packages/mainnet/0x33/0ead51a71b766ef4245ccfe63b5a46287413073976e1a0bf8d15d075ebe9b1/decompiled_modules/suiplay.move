module 0x330ead51a71b766ef4245ccfe63b5a46287413073976e1a0bf8d15d075ebe9b1::suiplay {
    struct SUIPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLAY>(arg0, 6, b"SUIPLAY", b"Sui Play", b"Meet $SUIPLAY. Inspired by the official SuiPlay0x1, this memecoin brings the fun of gaming to the Sui Network. Just like your favorite game console, Sui Play is all about leveling up, collecting wins, and having a blast.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/PP_6d97786d83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

