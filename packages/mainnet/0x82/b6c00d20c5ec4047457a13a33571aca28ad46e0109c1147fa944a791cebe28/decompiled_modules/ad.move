module 0x82b6c00d20c5ec4047457a13a33571aca28ad46e0109c1147fa944a791cebe28::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AD>, arg1: 0x2::coin::Coin<AD>) {
        0x2::coin::burn<AD>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AD>>(0x2::coin::mint<AD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 9, b"AD", b"Adapt Token", b"The first agent network protocol (ANP3) for crypto trading. Connected agents empower everyone to trade like experts and adapt to the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://adapt-anp3.ai/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AD>>(0x2::coin::mint<AD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
    }

    public fun revoke_minting(arg0: 0x2::coin::TreasuryCap<AD>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AD>>(arg0);
    }

    // decompiled from Move bytecode v7
}

