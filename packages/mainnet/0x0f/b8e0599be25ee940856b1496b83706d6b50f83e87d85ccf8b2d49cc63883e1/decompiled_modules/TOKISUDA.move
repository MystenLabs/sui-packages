module 0xfb8e0599be25ee940856b1496b83706d6b50f83e87d85ccf8b2d49cc63883e1::TOKISUDA {
    struct TOKISUDA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKISUDA>, arg1: 0x2::coin::Coin<TOKISUDA>) {
        0x2::coin::burn<TOKISUDA>(arg0, arg1);
    }

    fun init(arg0: TOKISUDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKISUDA>(arg0, 9, b"TOKISUDA", b"Golden Eggs", b"Ryan Coin Demo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-unfair-mackerel-372.mypinata.cloud/ipfs/QmYFh6RKLgYk8Ehx5HddTpgtdwN6KSVgjYrtRMKt1ojLrq")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKISUDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKISUDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKISUDA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKISUDA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

