module 0x70d4e4cc6c8cc6c49d5cd4aeb5d68b0c3b74b1a670a8bbab0d8d963e63c8e1e8::marktranet_faucet_coin {
    struct MARKTRANET_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARKTRANET_FAUCET_COIN>, arg1: 0x2::coin::Coin<MARKTRANET_FAUCET_COIN>) {
        0x2::coin::burn<MARKTRANET_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: MARKTRANET_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKTRANET_FAUCET_COIN>(arg0, 9, b"MARKTRANET_FAUCET_COIN", b"MARKTRANET_FAUCET_COIN", b"marktranet's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167279101")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARKTRANET_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MARKTRANET_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARKTRANET_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MARKTRANET_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

