module 0xc600159d75cad21269f3292c003dfe816462b891f02cf534cf74a4cf8dffd17f::kabuso {
    struct KABUSO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KABUSO>, arg1: 0x2::coin::Coin<KABUSO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KABUSO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KABUSO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KABUSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABUSO>(arg0, 6, b"KABUSO SUI", b"KABUSO", b"$KABUSO  https://x.com/kabuso_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmY2p7knCbj3WBSNTGsM8JZnrdYexAGH6sprBbixTSQKQQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KABUSO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABUSO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KABUSO>, arg1: 0x2::coin::Coin<KABUSO>) : u64 {
        0x2::coin::burn<KABUSO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KABUSO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KABUSO> {
        0x2::coin::mint<KABUSO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

