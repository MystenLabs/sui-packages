module 0x10957774361c9c7c401380ab71db28b7304e9addb47f024f838672a62dda129::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 6, b"JERRY", b"Jerry Maguire on $STAX", b"What can I do for ya? Its a very personal, you ready? Im ready. Show me the money! Feels good, huh? Say it with me! Show you the money. No! Show me the money! Show me the money! Louder! SHOW ME THE MONEY! Yes! You gotta yell that!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jerry_c0116fd789.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

