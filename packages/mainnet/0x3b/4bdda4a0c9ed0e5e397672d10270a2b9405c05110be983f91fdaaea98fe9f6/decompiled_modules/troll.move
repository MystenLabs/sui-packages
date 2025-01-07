module 0x3b4bdda4a0c9ed0e5e397672d10270a2b9405c05110be983f91fdaaea98fe9f6::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 9, b"TR", b"TRn", b"Tr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/daniel23/image/upload/v1705188555/WhatsApp_Image_2024-01-13_at_23.58.45_ypsuqz.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLL>>(v1);
        0x2::coin::mint_and_transfer<TROLL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

