module 0x89ef6b4970160aa55fe5f64390654bd0c96aa42ce843d027dad66100e1c828ee::numnum {
    struct NUMNUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUMNUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUMNUM>(arg0, 6, b"NUMNUM", b"numnum", b"I eat all things. Ass, cash, trash. Come with me if u are hungry, i've got some places to find some gems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EK_Eu_Cwni_400x400_9e3fe3fa7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUMNUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUMNUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

