module 0xb12af66f5543d7946bc4c65bb48611885041f0e686c10ade56662747922b58f::drg {
    struct DRG has drop {
        dummy_field: bool,
    }

    public entry fun update_description<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_description<T0>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<T0>(arg0, arg1, arg2);
    }

    public entry fun update_symbol<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<T0>(arg0, arg1, arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<DRG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DRG>>(arg0, arg1);
    }

    fun init(arg0: DRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRG>(arg0, 9, b"DRG", b"DarkGuardians", b"A coin made on Interest Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/7GnUJrb.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DRG>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRG>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

