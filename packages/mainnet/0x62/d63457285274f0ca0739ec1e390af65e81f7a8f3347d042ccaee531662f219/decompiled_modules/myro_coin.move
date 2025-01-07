module 0x62d63457285274f0ca0739ec1e390af65e81f7a8f3347d042ccaee531662f219::myro_coin {
    struct MYRO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYRO_COIN>, arg1: 0x2::coin::Coin<MYRO_COIN>) {
        0x2::coin::burn<MYRO_COIN>(arg0, arg1);
    }

    fun init(arg0: MYRO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO_COIN>(arg0, 9, b"MYRO", b"MYRO", b"https://twitter.com/MyroSui https://www.myrothedoge.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://jij7vcc6bueij3a524ofi74p24fo5zdkfgstga7tjxakqmurq6wa.arweave.net/ShP6iF4NCITsHdccVH-P1wru5GoppTMD803AqDKRh6w"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYRO_COIN>>(v1);
        0x2::coin::mint_and_transfer<MYRO_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MYRO_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYRO_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYRO_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

