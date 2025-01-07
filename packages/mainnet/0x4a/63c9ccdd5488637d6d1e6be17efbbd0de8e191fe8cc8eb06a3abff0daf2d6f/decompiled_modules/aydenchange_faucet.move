module 0x4a63c9ccdd5488637d6d1e6be17efbbd0de8e191fe8cc8eb06a3abff0daf2d6f::aydenchange_faucet {
    struct AYDENCHANGE_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AYDENCHANGE_FAUCET>, arg1: 0x2::coin::Coin<AYDENCHANGE_FAUCET>) {
        0x2::coin::burn<AYDENCHANGE_FAUCET>(arg0, arg1);
    }

    fun init(arg0: AYDENCHANGE_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYDENCHANGE_FAUCET>(arg0, 6, b"AYDENCHANGE_FAUCET", b"AYDENCHANGE_FAUCET", b"this is aydenchangefaucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYDENCHANGE_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<AYDENCHANGE_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AYDENCHANGE_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AYDENCHANGE_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

