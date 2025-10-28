module 0x3cacaca5415d188e271982d88b832478a11d3dec0c42530a13176b2b3539847e::hey {
    struct HEY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HEY>, arg1: 0x2::coin::Coin<HEY>) {
        0x2::coin::burn<HEY>(arg0, arg1);
    }

    fun init(arg0: HEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEY>(arg0, 9, b"HEY", b"Hey", b"hey guys!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gocoin.one/uploads/logo_1761636907443_170cfbaf.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

