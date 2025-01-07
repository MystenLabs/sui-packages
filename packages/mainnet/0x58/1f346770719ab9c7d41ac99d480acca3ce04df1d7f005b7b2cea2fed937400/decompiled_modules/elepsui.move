module 0x581f346770719ab9c7d41ac99d480acca3ce04df1d7f005b7b2cea2fed937400::elepsui {
    struct ELEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPSUI>(arg0, 9, b"ELEPSUI", b"Elephant On Sui", b"$ELepSui - Blue ELEPHANT  is Frustrated Because He's Too Cool!  A unique meme only on Sui Blockchain. Telegram: https://t.me/elephantsui , Web: https://elephantcoin.fun , X: https://x.com/ElephantSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GZRhQw2bYAAjoIZ?format=png&name=360x360")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELEPSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

