module 0x784da80df10feb62378c2af4b2841b862fc8214e3b6f7a662578ccc52b8f21bd::catcho {
    struct CATCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCHO>(arg0, 6, b"CATCHO", b"Catcho On Sui", b"The cutest cat on sui  is $CATCHO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014488_5671168db5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

