module 0xf664e374938092a8b88fd050fcc2f8a9960dd6418954447e03ab6b16e434fb8::luisui {
    struct LUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUISUI>(arg0, 6, b"LUISUI", b"LUIS", b"LUISUI IS LUI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/source_2947549965_9a527bba31.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

