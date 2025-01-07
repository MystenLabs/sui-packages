module 0xfef74cc9506bc5d2002cf2671dc019eb59e3cd21a24923b54b2e7efe239641bd::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIS>, arg1: 0x2::coin::Coin<SUIS>) {
        0x2::coin::burn<SUIS>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<SUIS>, arg1: &mut 0x2::coin::CoinMetadata<SUIS>, arg2: 0x1::string::String) {
        0x2::coin::update_description<SUIS>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<SUIS>, arg1: &mut 0x2::coin::CoinMetadata<SUIS>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<SUIS>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<SUIS>, arg1: &mut 0x2::coin::CoinMetadata<SUIS>, arg2: 0x1::string::String) {
        0x2::coin::update_name<SUIS>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<SUIS>, arg1: &mut 0x2::coin::CoinMetadata<SUIS>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<SUIS>(arg0, arg1, arg2);
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 9, b"SUIS", b"SUIS", b"The Suistart Platform (SUIS)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suistart.com/img/logo.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIS>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SUIS>(arg0) == 0, 1);
        0x2::coin::mint_and_transfer<SUIS>(arg0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    public entry fun transfer_coin_owner(arg0: 0x2::coin::CoinMetadata<SUIS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIS>>(arg0, arg1);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<SUIS>, arg1: 0x2::coin::CoinMetadata<SUIS>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIS>>(arg1, arg2);
    }

    public entry fun transfer_treasury_owner(arg0: 0x2::coin::TreasuryCap<SUIS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

