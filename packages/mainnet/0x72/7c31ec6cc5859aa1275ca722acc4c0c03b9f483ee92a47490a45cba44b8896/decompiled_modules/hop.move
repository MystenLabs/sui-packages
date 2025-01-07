module 0x727c31ec6cc5859aa1275ca722acc4c0c03b9f483ee92a47490a45cba44b8896::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HOP>, arg1: 0x2::coin::Coin<HOP>) {
        0x2::coin::burn<HOP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HOP>>(0x2::coin::mint<HOP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 9, b"hop", b"Hop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"test")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

