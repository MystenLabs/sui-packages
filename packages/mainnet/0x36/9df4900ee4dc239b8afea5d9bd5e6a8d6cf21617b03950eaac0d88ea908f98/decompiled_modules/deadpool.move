module 0x369df4900ee4dc239b8afea5d9bd5e6a8d6cf21617b03950eaac0d88ea908f98::deadpool {
    struct DEADPOOL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEADPOOL>, arg1: 0x2::coin::Coin<DEADPOOL>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEADPOOL>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEADPOOL>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DEADPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADPOOL>(arg0, 6, b"DEAD", b"Deadpool & Wolverine", b"welcome to $DEAD , you glorious fuckers!  https://x.com/deadwolcoin  https://t.me/deadpolcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRbaRo8WfaGMUYRd4rrZ2JcBwsRVbQZgLa4cyfjCsoNAu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEADPOOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADPOOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DEADPOOL>, arg1: 0x2::coin::Coin<DEADPOOL>) : u64 {
        0x2::coin::burn<DEADPOOL>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DEADPOOL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DEADPOOL> {
        0x2::coin::mint<DEADPOOL>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

