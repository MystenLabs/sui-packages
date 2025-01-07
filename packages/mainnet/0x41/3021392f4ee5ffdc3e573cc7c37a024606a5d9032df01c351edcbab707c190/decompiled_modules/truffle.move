module 0x413021392f4ee5ffdc3e573cc7c37a024606a5d9032df01c351edcbab707c190::truffle {
    struct TRUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUFFLE>(arg0, 6, b"TRUFFLE", b"Truffle Token Sui", b"The Legend of Truff: The Truffle-Hunting King Once upon a time, in a world full of ordinary pigs, one snout stood outTruff, the pig with an extraordinary gift for sniffing out the rarest, juiciest truffles. But these werent just any truffles; they were magical gems that held the secrets to endless crypto gains. With his loyal pack of crypto-sniffing pigs, Truff roams the digital forest in search of riches, fame, and a community of degens who share his passion for truffle-powered adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_222948_211_18efb9e0b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

