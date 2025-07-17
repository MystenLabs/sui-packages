module 0x2982fea89cca1147fdb0eb76be36830bd8529d46e7dfd19e788d958bbf40da0::pawmp {
    struct PAWMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWMP>(arg0, 6, b"PAWMP", b"Cheetah Den", b"Founder of $PAWMP | Meme Coin + Music + Energy Movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicrcvzytbptykk5jak5u7uzkpulydentlar25ov3slx4hgziz2z6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAWMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

