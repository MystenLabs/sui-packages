module 0x8344ccd26ca712975e2be5300d56ee0fea2105dd0843a296a805a1f105615304::dinos {
    struct DINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOS>(arg0, 6, b"DINOS", b"Dinosuir", x"f09fa6965374657020627920737465702c2077652772652067726f77696e67207374726f6e67657220616e6420726973696e67206869676865722c207265616368696e6720666f722074686520746f702120576527726520726561647920746f2073686f6f7420666f7220746865206d6f6f6e21f09fa6962e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731230223707.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

