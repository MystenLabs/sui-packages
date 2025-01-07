module 0x9121176b4ad6aef1865d99bf31ce7ab19490d9ba8e9dccff72ba510ba8fa71e6::csdv_faucet {
    struct CSDV_FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CSDV_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CSDV_FAUCET>>(0x2::coin::mint<CSDV_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CSDV_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSDV_FAUCET>(arg0, 6, b"CSDV FAUCET", b"CSDV FAUCET", b"CSDV FAUCET", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSDV_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CSDV_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

