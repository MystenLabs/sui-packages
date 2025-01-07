module 0x7f179f898363417b38f45c58ff4c2fb2bdb9a533a125b1977d4ce739f3d5787a::rimuru {
    struct RIMURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIMURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIMURU>(arg0, 6, b"RIMURU", b"Rimuru Coin", b"From Slime to Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Aesthetic_Phone_Mockup_Instagram_Post_53_9b1753d0c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIMURU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIMURU>>(v1);
    }

    // decompiled from Move bytecode v6
}

