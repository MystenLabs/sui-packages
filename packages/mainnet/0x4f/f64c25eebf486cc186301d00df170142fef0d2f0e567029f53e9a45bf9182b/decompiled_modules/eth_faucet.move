module 0x4ff64c25eebf486cc186301d00df170142fef0d2f0e567029f53e9a45bf9182b::eth_faucet {
    struct ETH_FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ETH_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH_FAUCET>>(0x2::coin::mint<ETH_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ETH_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH_FAUCET>(arg0, 8, b"ETH", b"Ethereum Test Coin", b"Test ETH token for testnet development and testing purposes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/eth.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

