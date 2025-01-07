module 0x7d2a2c5d9906c8cef0fd674d7620c3efe2134b2fb6f9e62b5c749da49b7abd8a::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAKKI>, arg1: 0x2::coin::Coin<RAKKI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAKKI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RAKKI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 6, b"Rakki Cat", b"RAKKI", x"52414b4b49206f6e20535549202d20546865206c75636b79206361742c206e6f77206d656f77696e67206f6e2053554920626c6f636b636861696ef09f92a7204c6574e280997320646f206d656d657320746f6765746865722e202068747470733a2f2f782e636f6d2f72616b6b696361742020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRj1dzxo7wAi8KCiRBzevwSxzPYyeWibjLzUXvH7SK7g2")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<RAKKI>, arg1: 0x2::coin::Coin<RAKKI>) : u64 {
        0x2::coin::burn<RAKKI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<RAKKI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RAKKI> {
        0x2::coin::mint<RAKKI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

