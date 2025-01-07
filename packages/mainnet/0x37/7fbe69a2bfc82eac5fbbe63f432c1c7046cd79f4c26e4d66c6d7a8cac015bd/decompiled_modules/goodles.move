module 0x377fbe69a2bfc82eac5fbbe63f432c1c7046cd79f4c26e4d66c6d7a8cac015bd::goodles {
    struct GOODLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODLES>(arg0, 6, b"GOODLES", b"Goodles", b"Noodles, Gooder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1440_PCP_Cheddy_Mac_403c4a1cec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOODLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

