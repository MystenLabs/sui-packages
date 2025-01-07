module 0x807276859673970446339214b5b04e51615aa91eddb65f292a49222fa8c9d764::tho2 {
    struct THO2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THO2>, arg1: 0x2::coin::Coin<THO2>) {
        0x2::coin::burn<THO2>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THO2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THO2>>(0x2::coin::mint<THO2>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<THO2>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO2>>(arg0, arg1);
    }

    fun init(arg0: THO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO2>(arg0, 6, b"THO2", b"THO2", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"icon_image")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

