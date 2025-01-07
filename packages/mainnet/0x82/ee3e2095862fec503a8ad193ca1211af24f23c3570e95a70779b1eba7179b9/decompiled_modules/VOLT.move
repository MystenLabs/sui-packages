module 0x82ee3e2095862fec503a8ad193ca1211af24f23c3570e95a70779b1eba7179b9::VOLT {
    struct VOLT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VOLT>, arg1: 0x2::coin::Coin<VOLT>) {
        0x2::coin::burn<VOLT>(arg0, arg1);
    }

    fun init(arg0: VOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLT>(arg0, 9, b"VOLT", b"VOLT INU", x"566f6c7420496e752069732061206d656d6520636f696e207468617420686173206e6f77206d616465206974e28099732077617920746f207468652073756920626c6f636b636861696e2c2061696d696e6720746f206265636f6d652074686520756c74696d617465206d656d6520636f696e20696e206120666c61736821205468697320646f67206973206261636b20696e20746f776e20616e642069732068756e67727920666f722066616d652e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/6vKD8rZ/volt.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VOLT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VOLT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

