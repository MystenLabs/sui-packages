module 0x35d723bddec6be8736d00449dc80d6947e88aaacc442fe27defb086b20545adc::bruh {
    struct BRUH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRUH>, arg1: 0x2::coin::Coin<BRUH>) {
        0x2::coin::burn<BRUH>(arg0, arg1);
    }

    fun init(arg0: BRUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUH>(arg0, 6, b"BRUH", b"Bruh Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fFxK25Z/bruh.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRUH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BRUH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

