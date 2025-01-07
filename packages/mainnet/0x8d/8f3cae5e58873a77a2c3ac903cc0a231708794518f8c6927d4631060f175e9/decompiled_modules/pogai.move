module 0x8d8f3cae5e58873a77a2c3ac903cc0a231708794518f8c6927d4631060f175e9::pogai {
    struct POGAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<POGAI>, arg1: 0x2::coin::Coin<POGAI>) {
        0x2::coin::burn<POGAI>(arg0, arg1);
    }

    fun init(arg0: POGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POGAI>(arg0, 6, b"POGAI", b"Proof of Great AI", b"The Strongest Meme + AI in History", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.pogai.org/img/logo.png"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POGAI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POGAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<POGAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<POGAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

