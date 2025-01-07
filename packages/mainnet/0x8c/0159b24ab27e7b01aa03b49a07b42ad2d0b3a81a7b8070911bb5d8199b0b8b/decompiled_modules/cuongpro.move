module 0x8c0159b24ab27e7b01aa03b49a07b42ad2d0b3a81a7b8070911bb5d8199b0b8b::cuongpro {
    struct CUONGPRO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CUONGPRO>, arg1: 0x2::coin::Coin<CUONGPRO>) {
        0x2::coin::burn<CUONGPRO>(arg0, arg1);
    }

    fun init(arg0: CUONGPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUONGPRO>(arg0, 2, b"Titan Trading Token", b"TES", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://titan-trading.storage.googleapis.com/images/27d1d8bbfd-256.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUONGPRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUONGPRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CUONGPRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CUONGPRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

