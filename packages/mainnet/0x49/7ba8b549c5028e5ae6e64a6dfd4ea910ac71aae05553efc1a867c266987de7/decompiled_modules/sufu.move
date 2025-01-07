module 0x497ba8b549c5028e5ae6e64a6dfd4ea910ac71aae05553efc1a867c266987de7::sufu {
    struct SUFU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUFU>, arg1: 0x2::coin::Coin<SUFU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUFU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUFU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUFU>(arg0, 6, b"SUFU", b"Striker coin", b"STRIKER IS A GLOBAL BLOCKCHAIN TOURNAMENT GAME WITH NFTS REWARDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/sqDmyMP")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUFU>, arg1: 0x2::coin::Coin<SUFU>) : u64 {
        0x2::coin::burn<SUFU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUFU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUFU> {
        0x2::coin::mint<SUFU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

