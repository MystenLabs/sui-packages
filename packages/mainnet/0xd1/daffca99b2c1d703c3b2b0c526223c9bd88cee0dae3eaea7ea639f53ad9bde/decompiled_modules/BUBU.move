module 0xd1daffca99b2c1d703c3b2b0c526223c9bd88cee0dae3eaea7ea639f53ad9bde::BUBU {
    struct BUBU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUBU>, arg1: 0x2::coin::Coin<BUBU>) {
        0x2::coin::burn<BUBU>(arg0, arg1);
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 9, b"BSUI", b"BUBU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/JpxTV4m/bubu.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUBU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BUBU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

