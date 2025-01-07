module 0xccb567c0a923dcdae6a1c166b955b1871a4514cf96ec3f6495778f8f97980830::suigoku {
    struct SUIGOKU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGOKU>, arg1: 0x2::coin::Coin<SUIGOKU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGOKU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIGOKU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIGOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOKU>(arg0, 6, b"Sui Goku", b"GOKU", b"Imagine an epic showdown between two iconic characters: Goku vs Charizard   https://suigoku.vip/  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmeYLFUGjbUJoEmyist6pdMnkQ5EhuCPGKbkyPULkaey9s")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIGOKU>, arg1: 0x2::coin::Coin<SUIGOKU>) : u64 {
        0x2::coin::burn<SUIGOKU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIGOKU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIGOKU> {
        0x2::coin::mint<SUIGOKU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

