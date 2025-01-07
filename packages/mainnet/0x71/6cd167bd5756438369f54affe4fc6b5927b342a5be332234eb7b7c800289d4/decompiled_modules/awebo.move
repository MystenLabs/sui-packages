module 0x716cd167bd5756438369f54affe4fc6b5927b342a5be332234eb7b7c800289d4::awebo {
    struct AWEBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: 0x2::coin::Coin<AWEBO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AWEBO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: AWEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWEBO>(arg0, 6, b"AWEBO", b"Awebo Token", x"f09f97a320566976612024415745424f20546f6b656e20436172616a6f20f09f9aa8436f6d6d756e697479204f776e6564207c2048756765204d454d45207c206f6e20535549f09f9299202020202068747470733a2f2f617765626f746f6b656e2e636f6d2f20202068747470733a2f2f782e636f6d2f417765626f546f6b656e202068747470733a2f2f742e6d652f617765626f746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmekkKUQG7BvEr5zCQfGVFVQP4JAR29xvgtnyZZQWEKGR4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWEBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWEBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: 0x2::coin::Coin<AWEBO>) : u64 {
        0x2::coin::burn<AWEBO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AWEBO> {
        0x2::coin::mint<AWEBO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

