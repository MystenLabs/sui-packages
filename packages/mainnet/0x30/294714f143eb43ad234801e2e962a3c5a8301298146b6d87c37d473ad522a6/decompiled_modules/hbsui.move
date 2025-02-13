module 0x30294714f143eb43ad234801e2e962a3c5a8301298146b6d87c37d473ad522a6::hbsui {
    struct HBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBSUI>(arg0, 6, b"HBSUI", b"HANA BEAR ON SUI", b"Ready to bounce with the cutest crew in crypto? Hana FN isnt just a meme coin its your chance to join a family thats wild, fun, and a little bit fluffy. Dont just watch from the sidelines; grab $HANA, hop in, and lets make this ride unforgettable. The kangaroo-bear vibes are calling will you answer?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hanafn_logo_01_db8f437739.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

