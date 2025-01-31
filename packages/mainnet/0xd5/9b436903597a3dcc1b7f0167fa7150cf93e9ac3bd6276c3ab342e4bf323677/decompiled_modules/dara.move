module 0xd59b436903597a3dcc1b7f0167fa7150cf93e9ac3bd6276c3ab342e4bf323677::dara {
    struct DARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARA>(arg0, 6, b"DARA", b"Dancing Rat", b"Dance and chat with our rat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rat_dance_0857c35e0c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

