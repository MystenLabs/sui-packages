module 0x3759ec8259d378c3117d25909cb3986e533a9f0707ee46f6322222ee54119e87::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINAMI>, arg1: 0x2::coin::Coin<SUINAMI>) {
        0x2::coin::burn<SUINAMI>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUINAMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINAMI>(arg0, 1000000000000000000, arg2, arg3);
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 6, b"NAMI", b"Suinami", b"Suinami. Surf the wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/tXwu9Kx.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

