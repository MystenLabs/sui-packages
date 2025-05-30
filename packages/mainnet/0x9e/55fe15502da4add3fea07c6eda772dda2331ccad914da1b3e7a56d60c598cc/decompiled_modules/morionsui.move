module 0x9e55fe15502da4add3fea07c6eda772dda2331ccad914da1b3e7a56d60c598cc::morionsui {
    struct MORIONSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MORIONSUI>, arg1: 0x2::coin::Coin<MORIONSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MORIONSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MORIONSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: MORIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORIONSUI>(arg0, 6, b"$MORI", b"mordecai & rigby", b"Mordecai & Rigby Memecoin $MORI is a playful and nostalgic memecoin inspired by the dynamic duo from Regular Show, Mordecai the blue jay and Rigby the raccoon.    https://x.com/morionsui  https://t.me/morionsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWZdJzCc82JY1enXpqhzKWiCPNuk1RsQwhLoVm62FRHyN")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORIONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORIONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<MORIONSUI>, arg1: 0x2::coin::Coin<MORIONSUI>) : u64 {
        0x2::coin::burn<MORIONSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<MORIONSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MORIONSUI> {
        0x2::coin::mint<MORIONSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

