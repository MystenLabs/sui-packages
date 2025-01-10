module 0x58c7d502972b4222baf66349d046f40fbad3db01df54c8026071ac7240ac6406::usda {
    struct USDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDA>(arg0, 6, b"Usd test token", b"USDA", b"Test USD token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

