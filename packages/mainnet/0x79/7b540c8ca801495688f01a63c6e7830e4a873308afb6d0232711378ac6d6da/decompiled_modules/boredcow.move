module 0x797b540c8ca801495688f01a63c6e7830e4a873308afb6d0232711378ac6d6da::boredcow {
    struct BOREDCOW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: 0x2::coin::Coin<BOREDCOW>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOREDCOW>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BOREDCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOREDCOW>(arg0, 6, b"BOO", b"BOO SUI", b"   https://x.com/booosui   https://t.me/+SCkx2EyKaio1Y2Fl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmdpVFX9advLLrQhho9M4KoV3LWyqeNWnc4ic1RAeXUvA9")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOREDCOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOREDCOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: 0x2::coin::Coin<BOREDCOW>) : u64 {
        0x2::coin::burn<BOREDCOW>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BOREDCOW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOREDCOW> {
        0x2::coin::mint<BOREDCOW>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

