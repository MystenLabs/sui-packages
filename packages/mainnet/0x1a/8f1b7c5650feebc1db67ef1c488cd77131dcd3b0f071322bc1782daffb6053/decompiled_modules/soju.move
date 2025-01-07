module 0x1a8f1b7c5650feebc1db67ef1c488cd77131dcd3b0f071322bc1782daffb6053::soju {
    struct SOJU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOJU>, arg1: 0x2::coin::Coin<SOJU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOJU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SOJU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SOJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOJU>(arg0, 6, b"SOJU SUI", b"SOJU", b"$SOJU. More than just a memecoin, SOJU provides utility by integrating into nightlife, entertainment, and digital spaces, offering discounts, rewards,  https://x.com/sojusui_  https://t.me/sojusui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-magnetic-ptarmigan-262.mypinata.cloud/ipfs/QmQ5jMMHaDkeP8LVDWQH96YGP7sNJzvm7ojoNHMiAderBs")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOJU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOJU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SOJU>, arg1: 0x2::coin::Coin<SOJU>) : u64 {
        0x2::coin::burn<SOJU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SOJU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SOJU> {
        0x2::coin::mint<SOJU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

