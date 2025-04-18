module 0x542af25df1eadb30fafc20e841ca15b7e5684803051695674e185f88b7c2f874::lbiyou_faucet {
    struct LBIYOU_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LBIYOU_FAUCET>, arg1: 0x2::coin::Coin<LBIYOU_FAUCET>) {
        0x2::coin::burn<LBIYOU_FAUCET>(arg0, arg1);
    }

    fun init(arg0: LBIYOU_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBIYOU_FAUCET>(arg0, 9, b"LBIYOU_FAUCET", b"LBIYOU_FAUCET", b"LBIYOU's faucet coin, everyone can apply.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/104566270?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBIYOU_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LBIYOU_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LBIYOU_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LBIYOU_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

