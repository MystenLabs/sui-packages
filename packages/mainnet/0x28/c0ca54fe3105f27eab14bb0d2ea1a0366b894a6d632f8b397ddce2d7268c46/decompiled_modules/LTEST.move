module 0x28c0ca54fe3105f27eab14bb0d2ea1a0366b894a6d632f8b397ddce2d7268c46::LTEST {
    struct LTEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LTEST>, arg1: 0x2::coin::Coin<LTEST>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LTEST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LTEST>>(0x2::coin::mint<LTEST>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<LTEST>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LTEST>>(arg0);
    }

    fun init(arg0: LTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTEST>(arg0, 9, b"LTEST", b"Lautus Test", b"Testing coin creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dictionary.com/e/wp-content/uploads/2018/03/asdfmovie-300x300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

