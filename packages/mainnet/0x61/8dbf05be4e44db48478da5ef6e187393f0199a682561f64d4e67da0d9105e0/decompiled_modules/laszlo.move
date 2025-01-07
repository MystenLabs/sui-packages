module 0x618dbf05be4e44db48478da5ef6e187393f0199a682561f64d4e67da0d9105e0::laszlo {
    struct LASZLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LASZLO>, arg1: 0x2::coin::Coin<LASZLO>) {
        0x2::coin::burn<LASZLO>(arg0, arg1);
    }

    fun init(arg0: LASZLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASZLO>(arg0, 9, b"Laszlo", b"10.000 BTC for 2 pizza", b"10.000 BTC for 2 pizza Laszlo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeX5EVAQKEjvDDtc1hEqoyD2X7svRpaAdrfXwWyNN4VfU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LASZLO>(&mut v2, 80000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LASZLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASZLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LASZLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LASZLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

