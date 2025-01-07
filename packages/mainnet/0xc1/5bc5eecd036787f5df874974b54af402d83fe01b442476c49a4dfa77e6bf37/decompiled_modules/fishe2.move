module 0xc15bc5eecd036787f5df874974b54af402d83fe01b442476c49a4dfa77e6bf37::fishe2 {
    struct FISHE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHE2>(arg0, 6, b"Fishe2", b"Fish1", b"Fishfw2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_2_3bd43b71ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHE2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHE2>>(v1);
    }

    // decompiled from Move bytecode v6
}

