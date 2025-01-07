module 0x6ad0c355997b2db6de587c21e60a31eb76bd88009fa12bac32667a4425132444::suikamala {
    struct SUIKAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKAMALA>(arg0, 9, b"SUIKAMALA", b"Sui Kamala Harris", b"Kamala Haris", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kamala-harris.io/img/main.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKAMALA>(&mut v2, 444000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKAMALA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

