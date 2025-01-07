module 0x7c78acd68256739c6978555b43a9adf0709ea7c11dc57198bddb1a7bd963e2ee::marscoin {
    struct MARSCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARSCOIN>, arg1: 0x2::coin::Coin<MARSCOIN>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARSCOIN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MARSCOIN>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: MARSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSCOIN>(arg0, 6, b"MARSCOIN", b"MARSCOIN", b"It is necessary. Maybe call it MarsCoin? https://x.com/marscoin_meme https://marscoineth.vip/ https://t.me/MarsCoin_portal  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmPj2esQ4Q7udZCUBbUESBvYo8G7py7vrAknrpjKikke1X")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARSCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<MARSCOIN>, arg1: 0x2::coin::Coin<MARSCOIN>) : u64 {
        0x2::coin::burn<MARSCOIN>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<MARSCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MARSCOIN> {
        0x2::coin::mint<MARSCOIN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

