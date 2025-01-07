module 0x717336e4025af1e3f653b7fb58d8a531041dd1d2d9b66e83f936b342f7f0c3e4::boosui {
    struct BOOSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOOSUI>, arg1: 0x2::coin::Coin<BOOSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOOSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSUI>(arg0, 6, b"BOO", b"BOO SUI", b"   https://x.com/booosui   https://t.me/+SCkx2EyKaio1Y2Fl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmdpVFX9advLLrQhho9M4KoV3LWyqeNWnc4ic1RAeXUvA9")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BOOSUI>, arg1: 0x2::coin::Coin<BOOSUI>) : u64 {
        0x2::coin::burn<BOOSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BOOSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOOSUI> {
        0x2::coin::mint<BOOSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

