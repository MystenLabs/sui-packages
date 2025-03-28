module 0xe1e643943a5a76715fbb11fad80c10244462dea0143151fcf9377586e7e53dbf::yuhuangdadi666_FAUCET_COIN {
    struct YUHUANGDADI666_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YUHUANGDADI666_FAUCET_COIN>, arg1: 0x2::coin::Coin<YUHUANGDADI666_FAUCET_COIN>) {
        0x2::coin::burn<YUHUANGDADI666_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: YUHUANGDADI666_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUHUANGDADI666_FAUCET_COIN>(arg0, 9, b"YUHUANGDADI666_FAUCET", b"YUHUANGDADI666_FAUCET", b"yuhaungdadi666's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/77825640?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUHUANGDADI666_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YUHUANGDADI666_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YUHUANGDADI666_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YUHUANGDADI666_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

