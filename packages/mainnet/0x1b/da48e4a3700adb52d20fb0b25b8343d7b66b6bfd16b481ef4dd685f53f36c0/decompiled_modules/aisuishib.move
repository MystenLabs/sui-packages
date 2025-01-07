module 0x1bda48e4a3700adb52d20fb0b25b8343d7b66b6bfd16b481ef4dd685f53f36c0::aisuishib {
    struct AISUISHIB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AISUISHIB>, arg1: 0x2::coin::Coin<AISUISHIB>) {
        0x2::coin::burn<AISUISHIB>(arg0, arg1);
    }

    fun init(arg0: AISUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUISHIB>(arg0, 2, b"AISUISHIB", b"SUIS", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUISHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AISUISHIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AISUISHIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

