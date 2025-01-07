module 0x68fb7723ef493cfe761f8891b93b36443cec64a3e5943e7294144395f8fe4898::suiksuok {
    struct SUIKSUOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKSUOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKSUOK>(arg0, 6, b"SuikSuok", b"Suik Suok", b"Tik Tok is on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIKSUOK_785d49e0ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKSUOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKSUOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

