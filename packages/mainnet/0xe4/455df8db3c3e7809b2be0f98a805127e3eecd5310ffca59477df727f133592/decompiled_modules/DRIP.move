module 0xe4455df8db3c3e7809b2be0f98a805127e3eecd5310ffca59477df727f133592::DRIP {
    struct DRIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRIP>, arg1: 0x2::coin::Coin<DRIP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRIP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DRIP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 6, b"DRIP", b"Drip", b"This is a Memcoin Sui Move!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/SQgCL1Qb/t0-OCTrba-400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DRIP>, arg1: 0x2::coin::Coin<DRIP>) : u64 {
        0x2::coin::burn<DRIP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DRIP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DRIP> {
        0x2::coin::mint<DRIP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

