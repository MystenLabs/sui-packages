module 0x88439b47f94255971f4b4588b181f4977c0b031add2fb47f8b58bad56671cee0::louie {
    struct LOUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOUIE>(arg0, 6, b"LOUIE", b"Sui Rat Louie", b"a rat that came to sniff out all the cheese on sui  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Rat_Louie_e3f9c51800.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOUIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

