module 0x5c498cd675dafa0daf098910aa3e009624bb41f35e90201b7117c3e0ce8300b8::rico {
    struct RICO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RICO>, arg1: 0x2::coin::Coin<RICO>) {
        0x2::coin::burn<RICO>(arg0, arg1);
    }

    fun init(arg0: RICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICO>(arg0, 9, b"Rico", b"Rico Porcupine the Sui", b"Rico the Porcupine, born of corn and SUI, dances through the chain with velvet quills and a mischievous grin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/Pepeonsui/refs/heads/main/rico.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<RICO>>(0x2::coin::mint<RICO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

