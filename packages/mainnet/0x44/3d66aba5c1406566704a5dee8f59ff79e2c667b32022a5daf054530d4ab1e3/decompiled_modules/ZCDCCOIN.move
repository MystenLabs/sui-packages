module 0x443d66aba5c1406566704a5dee8f59ff79e2c667b32022a5daf054530d4ab1e3::ZCDCCOIN {
    struct ZCDCCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZCDCCOIN>, arg1: 0x2::coin::Coin<ZCDCCOIN>) {
        0x2::coin::burn<ZCDCCOIN>(arg0, arg1);
    }

    fun init(arg0: ZCDCCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZCDCCOIN>(arg0, 6, b"ZCDCCoin", b"ZCDCCoin", b"ZCDCCoin is NO.1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/n-e_Ni4LwoBJUwu_Ovccl7Lflh_NmHmvwMpLWLRwCt0")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZCDCCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZCDCCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZCDCCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZCDCCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

