module 0x16790141dfb659d409c915157dd617a50249b2ec8fe0cf9aed7c1e279aca1461::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: 0x2::coin::Coin<ZOMBIE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZOMBIE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"ZOMBIE", x"5a6f6d626965535549f09fa79fe2808de29982", b"  https://www.zombiesui.fun/  https://x.com/zombiesui  https://t.me/zombiesuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmVjMyp6dgeJZTgxKJ5WR889uAwumsK27zSV31iG28cfqi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: 0x2::coin::Coin<ZOMBIE>) : u64 {
        0x2::coin::burn<ZOMBIE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ZOMBIE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZOMBIE> {
        0x2::coin::mint<ZOMBIE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

