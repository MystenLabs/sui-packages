module 0x165a8a636ad781363c998df06bc2c887193a7a2c428c1e97b944e81148772068::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 9, b"FAUCET", b"FAUCET COIN", b"One Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cxoevc6nxqzhidpbr2h67eyyujeeyazwipodezy35nhxqxd52sya.arweave.net/FdxKi828MnQN4Y6P75MYokhMAzZD3DJnG-tPeFx91LA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

