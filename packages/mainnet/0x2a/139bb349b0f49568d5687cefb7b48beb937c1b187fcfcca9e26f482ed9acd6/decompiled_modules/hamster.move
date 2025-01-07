module 0x2a139bb349b0f49568d5687cefb7b48beb937c1b187fcfcca9e26f482ed9acd6::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"HAMSTER", b"HAMSTERDANCE ON SUI", b"Dance the night away : https://hamstersui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_9c822913b9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

