module 0x7b96c6a2e690a7111fefb6765507525a77ca4238948e04d5343a866ec98968f4::toji {
    struct TOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOJI>(arg0, 6, b"Toji", b"Sorcerer Killer", b"Toji Fushiguro the one who left it all behind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiandri2jo7zy74hzvtaub2rgys4xvs2564n77oateylyjbz6whezi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOJI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

