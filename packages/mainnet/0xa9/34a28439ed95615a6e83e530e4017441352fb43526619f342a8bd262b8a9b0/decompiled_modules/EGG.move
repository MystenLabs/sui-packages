module 0xa934a28439ed95615a6e83e530e4017441352fb43526619f342a8bd262b8a9b0::EGG {
    struct EGG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EGG>, arg1: 0x2::coin::Coin<EGG>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<EGG>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EGG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EGG>>(0x2::coin::mint<EGG>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<EGG>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EGG>>(arg0);
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 9, b"Egg", b"Egg ", b"Just a random egg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_684c9f6cefafa3.56376646.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

