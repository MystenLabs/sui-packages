module 0xb4ea041850ca08ee26878bdbb27e4d28537e84d8cde11472f0c444e757bf207d::gunksd_faucet {
    struct GUNKSD_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUNKSD_FAUCET>, arg1: 0x2::coin::Coin<GUNKSD_FAUCET>) {
        0x2::coin::burn<GUNKSD_FAUCET>(arg0, arg1);
    }

    fun init(arg0: GUNKSD_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNKSD_FAUCET>(arg0, 6, b"GUNKSD_FAUCET", b"gunksd_faucet", b"gunksd faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUNKSD_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNKSD_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUNKSD_FAUCET>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUNKSD_FAUCET>(arg0, 1000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

