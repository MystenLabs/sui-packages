module 0x204818479726c0c721f41db750584b1cdd4caef44aa9f459027eaaeafaca7945::hsui {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 6, b"HSUI", b"Housecoin SUI", b"if you hate housecoin we still love you and will crash the housing market for you to get a great entry for your family big bruh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia4ytsq474b53wih3zzea6di6qt4ghqlbuigqdxh4vzbi2n5chqai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

