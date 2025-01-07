module 0x972fcccd4a9480c4aff3b3ac0bb16c10036fa52dd110d14242fe282e69204b88::shisui {
    struct SHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHISUI>(arg0, 6, b"Shisui", b"Uchiha shisui", b"Let them know the power of the Uchiha clan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000591_94fd9b4b7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

