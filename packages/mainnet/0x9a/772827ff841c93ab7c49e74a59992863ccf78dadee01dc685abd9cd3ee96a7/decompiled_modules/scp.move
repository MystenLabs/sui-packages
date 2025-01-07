module 0x9a772827ff841c93ab7c49e74a59992863ccf78dadee01dc685abd9cd3ee96a7::scp {
    struct SCP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCP>, arg1: 0x2::coin::Coin<SCP>) {
        0x2::coin::burn<SCP>(arg0, arg1);
    }

    fun init(arg0: SCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCP>(arg0, 2, b"SCP", b"SCP Coin", b"...SCP 999 colledge funds...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/en/0/0a/Logo_of_the_SCP_Foundation.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

