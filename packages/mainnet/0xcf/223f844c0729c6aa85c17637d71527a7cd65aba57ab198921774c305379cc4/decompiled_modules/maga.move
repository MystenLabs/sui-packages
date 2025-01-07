module 0xcf223f844c0729c6aa85c17637d71527a7cd65aba57ab198921774c305379cc4::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"MAGA", b"MAGA", b"MAGA is a pioneering token on the Sui network, designed for decentralized gaming and betting applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61CT+4jQ2gL._AC_UF894,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<MAGA>(arg0, arg1);
        0x2::coin::mint_and_transfer<MAGA>(&mut v0, 10000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAGA>>(v0);
    }

    // decompiled from Move bytecode v6
}

