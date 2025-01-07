module 0xe5e73540dcbae12d87fd77b7683deba65c0f8ab551eee01c4dd0856a2d81e837::newchadsuicto {
    struct NEWCHADSUICTO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: 0x2::coin::Coin<NEWCHADSUICTO>) {
        0x2::coin::burn<NEWCHADSUICTO>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: &mut 0x2::coin::CoinMetadata<NEWCHADSUICTO>, arg2: 0x1::string::String) {
        0x2::coin::update_description<NEWCHADSUICTO>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url(arg0: &mut 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: &mut 0x2::coin::CoinMetadata<NEWCHADSUICTO>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<NEWCHADSUICTO>(arg0, arg1, arg2);
    }

    public entry fun update_name(arg0: &mut 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: &mut 0x2::coin::CoinMetadata<NEWCHADSUICTO>, arg2: 0x1::string::String) {
        0x2::coin::update_name<NEWCHADSUICTO>(arg0, arg1, arg2);
    }

    public entry fun update_symbol(arg0: &mut 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: &mut 0x2::coin::CoinMetadata<NEWCHADSUICTO>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<NEWCHADSUICTO>(arg0, arg1, arg2);
    }

    fun init(arg0: NEWCHADSUICTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWCHADSUICTO>(arg0, 9, b"chadcto", b"new chad sui cto", b"new chad SUI CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/3dtsTl5.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEWCHADSUICTO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWCHADSUICTO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEWCHADSUICTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEWCHADSUICTO>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<NEWCHADSUICTO>, arg1: 0x2::coin::CoinMetadata<NEWCHADSUICTO>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWCHADSUICTO>>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEWCHADSUICTO>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

