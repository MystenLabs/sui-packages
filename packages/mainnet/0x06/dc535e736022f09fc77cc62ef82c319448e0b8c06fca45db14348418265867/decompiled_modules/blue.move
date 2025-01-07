module 0x6dc535e736022f09fc77cc62ef82c319448e0b8c06fca45db14348418265867::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUE>, arg1: 0x2::coin::Coin<BLUE>) {
        0x2::coin::burn<BLUE>(arg0, arg1);
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"BLUE", b"Bluefin", b"Bluefin foundation coin earned by trading on the Bluefin protocol and used to partake in governance proposals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/square.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BLUE>(arg0) + arg1 <= 1000000000000000000, 1);
        0x2::coin::mint_and_transfer<BLUE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

