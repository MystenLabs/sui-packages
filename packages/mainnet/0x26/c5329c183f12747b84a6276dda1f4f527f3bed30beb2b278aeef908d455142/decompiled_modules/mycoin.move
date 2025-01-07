module 0x26c5329c183f12747b84a6276dda1f4f527f3bed30beb2b278aeef908d455142::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"BITCH", b"Example coin", b"This is a coin that I created along my journey to learn Sui Move!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmSo64UajcKbuR2c9Toe8t5EJPrNqayTZypvfoaG5L8Ejg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) : u64 {
        0x2::coin::burn<MYCOIN>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MYCOIN> {
        0x2::coin::mint<MYCOIN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

