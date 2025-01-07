module 0x2f26860c405e3870b3cb7754a78e5eec7b00e470f27dbca1188c4c13a866688d::stoink {
    struct STOINK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STOINK>, arg1: 0x2::coin::Coin<STOINK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STOINK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STOINK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: STOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOINK>(arg0, 6, b"Stoink on Sui", b"STOINK", b"It's time for UPTOBER to go crazy, UPTOBER will reach every corner of the planet.  https://x.com/stoinksui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmPM74SqTdW85mGa9A6XFwcoPxcQnkY535xfyMwk6RGK8s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STOINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<STOINK>, arg1: 0x2::coin::Coin<STOINK>) : u64 {
        0x2::coin::burn<STOINK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<STOINK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STOINK> {
        0x2::coin::mint<STOINK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

