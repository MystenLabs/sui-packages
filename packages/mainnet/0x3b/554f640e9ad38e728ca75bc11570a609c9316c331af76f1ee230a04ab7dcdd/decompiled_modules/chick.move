module 0x3b554f640e9ad38e728ca75bc11570a609c9316c331af76f1ee230a04ab7dcdd::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"Sui Chick", b"$CHICK may look cute, but its all about that bold Sui attitude. Peep, peep dont sleep on this one! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_86_4f540e16c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

