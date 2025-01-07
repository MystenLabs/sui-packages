module 0xc8e197a31753284ce547958f2e72052d51a6e852caea0647fe3094cab2704b92::samurai {
    struct SAMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMURAI>(arg0, 6, b"SAMURAI", b"$SAMURAI", b"Katanas should always be sharp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5852_9968daf3c6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

