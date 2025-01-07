module 0xa9d7f88a7e3cee8fc8798388e74c1bbc34cc88e1b0300eb43ef475247cc156b1::slre {
    struct SLRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLRE>(arg0, 6, b"SLRE", b"suillionaire", b"be rich from sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_13_52_51_ce022846ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

