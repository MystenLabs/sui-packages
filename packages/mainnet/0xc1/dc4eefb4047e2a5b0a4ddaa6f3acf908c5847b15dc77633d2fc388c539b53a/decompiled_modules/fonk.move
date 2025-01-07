module 0xc1dc4eefb4047e2a5b0a4ddaa6f3acf908c5847b15dc77633d2fc388c539b53a::fonk {
    struct FONK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FONK>, arg1: 0x2::coin::Coin<FONK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FONK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FONK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: FONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FONK>(arg0, 6, b"$FONK", b"Fonk Sui", b"$FONK Coin is a playful and vibrant memecoin designed to enhance the entertainment experience within a casino ecosystem.    https://x.com/fonksui  https://t.me/fonkonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmR3diLJpbN2VRt5JiNAKRC98BKqreQFMPY1xFrYnm6zhk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<FONK>, arg1: 0x2::coin::Coin<FONK>) : u64 {
        0x2::coin::burn<FONK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FONK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FONK> {
        0x2::coin::mint<FONK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

