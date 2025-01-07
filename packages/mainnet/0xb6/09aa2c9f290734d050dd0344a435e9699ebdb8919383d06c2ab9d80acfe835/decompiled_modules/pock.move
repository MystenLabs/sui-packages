module 0xb609aa2c9f290734d050dd0344a435e9699ebdb8919383d06c2ab9d80acfe835::pock {
    struct POCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCK>(arg0, 6, b"POCK", b"Pock Fish", b"Just them pock ur foots", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Troll_Fish_Nemo_Colours_46da796bd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

