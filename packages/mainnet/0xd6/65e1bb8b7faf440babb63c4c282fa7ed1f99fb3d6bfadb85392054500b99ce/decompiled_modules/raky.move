module 0xd665e1bb8b7faf440babb63c4c282fa7ed1f99fb3d6bfadb85392054500b99ce::raky {
    struct RAKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAKY>, arg1: 0x2::coin::Coin<RAKY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAKY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RAKY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: RAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKY>(arg0, 6, b"RAKY", b"RAKY", b"Raky isn't just a memecoin   https://www.raky.pro/   https://x.com/rakysui   https://t.me/rakysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmdoB1wBvU3TjopQ1i2kQXCWypsuzLP2omS3R88aUEUbsN")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<RAKY>, arg1: 0x2::coin::Coin<RAKY>) : u64 {
        0x2::coin::burn<RAKY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<RAKY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RAKY> {
        0x2::coin::mint<RAKY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

