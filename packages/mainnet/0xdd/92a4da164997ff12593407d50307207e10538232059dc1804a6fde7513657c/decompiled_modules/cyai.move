module 0xdd92a4da164997ff12593407d50307207e10538232059dc1804a6fde7513657c::cyai {
    struct CYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYAI>(arg0, 6, b"CYAI", b"Crypter AI ON SUI", b"Crypter AI takes the throne, whoever plays is the winner!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_Gold_Circle_Ribbon_Illustration_Modern_Football_Team_Logo_53e6cdc967.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

