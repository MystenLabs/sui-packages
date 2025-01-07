module 0xf53702051e1304c8239599adc1745b1e30e8b1fea53e57847975747d1ecbd49::ordi {
    struct ORDI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ORDI>, arg1: 0x2::coin::Coin<ORDI>) {
        0x2::coin::burn<ORDI>(arg0, arg1);
    }

    fun init(arg0: ORDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORDI>(arg0, 8, b"ORDI", b"ORDI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ordinalswallet.com/brc20-logos/ordi.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ORDI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ORDI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

