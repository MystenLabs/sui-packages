module 0xa54df58ab46153990dcd8ded957b65a7373aa8c57ed48d259b7556c8f4127250::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CRAB>, arg1: 0x2::coin::Coin<CRAB>) {
        0x2::coin::burn<CRAB>(arg0, arg1);
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 9, b"CRAB", b"CRAB ", b"CRAB Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Fv_GpGoaUAAVrfo?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CRAB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CRAB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

