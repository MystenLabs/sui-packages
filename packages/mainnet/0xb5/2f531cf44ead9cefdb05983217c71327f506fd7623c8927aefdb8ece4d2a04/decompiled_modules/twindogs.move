module 0xb52f531cf44ead9cefdb05983217c71327f506fd7623c8927aefdb8ece4d2a04::twindogs {
    struct TWINDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWINDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWINDOGS>(arg0, 6, b"TwinDogs", b"TWINDOGSSUI", b"Twin DOGS is live eating", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004807_2bf7194c24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWINDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWINDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

