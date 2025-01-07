module 0xf791912fb94739ecdc9015b3bc72261f5a6ca31d52f8a58222f12be4f77a5293::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SMILE>, arg1: 0x2::coin::Coin<SMILE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SMILE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SMILE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"SMILE", b"Smile", b"Proof of Gratitude Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suizzle.com/wp-content/uploads/2023/07/smile_0001.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SMILE>, arg1: 0x2::coin::Coin<SMILE>) : u64 {
        0x2::coin::burn<SMILE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SMILE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SMILE> {
        0x2::coin::mint<SMILE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

