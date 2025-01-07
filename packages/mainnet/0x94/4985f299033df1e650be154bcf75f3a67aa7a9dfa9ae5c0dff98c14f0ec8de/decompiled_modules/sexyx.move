module 0x944985f299033df1e650be154bcf75f3a67aa7a9dfa9ae5c0dff98c14f0ec8de::sexyx {
    struct SEXYX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SEXYX>, arg1: 0x2::coin::Coin<SEXYX>) {
        0x2::coin::burn<SEXYX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEXYX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEXYX>>(0x2::coin::mint<SEXYX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SEXYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXYX>(arg0, 9, b"sexyx", b"SEXYX", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEXYX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXYX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

