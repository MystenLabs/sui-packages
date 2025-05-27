module 0x6c75a687accaec566149d51834409689e54a537ddbcae438ee72a4c9f4091888::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: &mut 0x2::coin::CoinMetadata<BOSU>, arg2: 0x1::string::String) {
        0x2::coin::update_description<BOSU>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: &mut 0x2::coin::CoinMetadata<BOSU>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<BOSU>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: &mut 0x2::coin::CoinMetadata<BOSU>, arg2: 0x1::string::String) {
        0x2::coin::update_name<BOSU>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: &mut 0x2::coin::CoinMetadata<BOSU>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<BOSU>(arg0, arg1, arg2);
    }

    public entry fun freeze_coin_metadata(arg0: 0x2::coin::CoinMetadata<BOSU>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(arg0);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<BOSU>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOSU>>(arg0);
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        let v1 = b"https://ipfs.io/ipfs/bafybeiba47nfcnjgqri43v5oajqdlzvaimlaoalsinvjsggjknzxipumzq";
        if (0x1::vector::length<u8>(&v1) > 0) {
            v0 = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1));
        };
        let (v2, v3) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book Of Sui", b"Book of Sui is the first presale born from X on the Sui chain no rules, no roadmap, just raw meme energy and on-chain madness.", v0, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BOSU>(&mut v4, 6900000420000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_coin_metadata(arg0: 0x2::coin::CoinMetadata<BOSU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSU>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<BOSU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

