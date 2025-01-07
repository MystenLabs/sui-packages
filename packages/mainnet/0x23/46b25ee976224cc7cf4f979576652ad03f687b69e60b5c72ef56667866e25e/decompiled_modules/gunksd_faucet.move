module 0x2346b25ee976224cc7cf4f979576652ad03f687b69e60b5c72ef56667866e25e::gunksd_faucet {
    struct GUNKSD_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUNKSD_FAUCET>, arg1: 0x2::coin::Coin<GUNKSD_FAUCET>) {
        0x2::coin::burn<GUNKSD_FAUCET>(arg0, arg1);
    }

    fun init(arg0: GUNKSD_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNKSD_FAUCET>(arg0, 6, b"GUNKSD_FAUCET", b"gunksd", b"gunksd faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUNKSD_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNKSD_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUNKSD_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUNKSD_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

