module 0x8d9db20388c89774ac9e996d91c040e01c5446bf91a33a9e1d843187428802b::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 6, b"POLA", b"Pola", b"I'm the coldest, chillest, and funniest bear in the entire Arctic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pola_Logo_9bf6ecf3f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

