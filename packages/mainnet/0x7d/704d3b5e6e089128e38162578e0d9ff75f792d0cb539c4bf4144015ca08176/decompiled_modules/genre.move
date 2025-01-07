module 0x2faf45ddcc489dfbf85239301f7ecc3320c1d25fd0144a34cc85f615ceaab09b::genre {
    struct GENRE has drop {
        dummy_field: bool,
    }

    public entry fun update_name(arg0: &0x2::coin::TreasuryCap<GENRE>, arg1: &mut 0x2::coin::CoinMetadata<GENRE>, arg2: 0x1::string::String) {
        0x2::coin::update_name<GENRE>(arg0, arg1, arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<GENRE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GENRE>>(arg0, arg1);
    }

    public entry fun burn_coins(arg0: &mut 0x2::coin::TreasuryCap<GENRE>, arg1: 0x2::coin::Coin<GENRE>) {
        0x2::coin::burn<GENRE>(arg0, arg1);
    }

    fun init(arg0: GENRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENRE>(arg0, 9, b"GENRE", b"GENRE Token", b"Genre Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/pvyLdDh/animal.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENRE>>(v1);
        0x2::coin::mint_and_transfer<GENRE>(&mut v2, 10000000000000000000, @0x1f51edf809fcb9a420de2f46bafc9fcd4dabdf306ee7ada18b5324285f477782, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENRE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<GENRE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENRE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

