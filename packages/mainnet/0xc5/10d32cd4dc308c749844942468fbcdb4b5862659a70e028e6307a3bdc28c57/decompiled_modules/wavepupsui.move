module 0xc510d32cd4dc308c749844942468fbcdb4b5862659a70e028e6307a3bdc28c57::wavepupsui {
    struct WAVEPUPSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAVEPUPSUI>, arg1: 0x2::coin::Coin<WAVEPUPSUI>) {
        0x2::coin::burn<WAVEPUPSUI>(arg0, arg1);
    }

    public entry fun create_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<WAVEPUPSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WAVEPUPSUI>(arg0, arg2, arg1, arg3);
    }

    fun init(arg0: WAVEPUPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUPSUI>(arg0, 9, b"WPS", b"WAVEPUPSUI", b"WavePupSui aims to ride the crest of the crypto wave with a digital native persona that sparks joy and fosters a tight-knit community. Encapsulating the playful and fresh spirit of Sui blockchain, this memecoin focuses on creating a wave of positive change in the decentralized economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-characteristic-echidna-176.mypinata.cloud/ipfs/bafybeidow6hnygt72nm233epfmlz3ormhljh7gsp6tbw5ghn7stelv43wa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAVEPUPSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun update_coin_info(arg0: 0x1::string::String, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::coin::TreasuryCap<WAVEPUPSUI>, arg5: &mut 0x2::coin::CoinMetadata<WAVEPUPSUI>) {
        0x2::coin::update_name<WAVEPUPSUI>(arg4, arg5, arg0);
        0x2::coin::update_symbol<WAVEPUPSUI>(arg4, arg5, 0x1::ascii::string(arg1));
        0x2::coin::update_description<WAVEPUPSUI>(arg4, arg5, arg2);
        0x2::coin::update_icon_url<WAVEPUPSUI>(arg4, arg5, 0x1::ascii::string(arg3));
    }

    // decompiled from Move bytecode v6
}

