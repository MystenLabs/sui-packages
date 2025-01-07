module 0x1edf11f26feac977a3e6aadf2b50ccb98ee7cda9f79e117ec9e7b7e83c5e9ae0::bozo_coin {
    struct BOZO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOZO_COIN>, arg1: 0x2::coin::Coin<BOZO_COIN>) {
        0x2::coin::burn<BOZO_COIN>(arg0, arg1);
    }

    fun init(arg0: BOZO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOZO_COIN>(arg0, 9, b"BOZO", b"BOZO", b"https://t.me/bozocoinsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://qqhvbjan3zh3v2zjtrwsomtg6v6ia3ryslhn2dhqsjfijpngjefa.arweave.net/hA9QpA3eT7rrKZxtJzJm9XyAbjiSzt0M8JJKhL2mSQo"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOZO_COIN>>(v1);
        0x2::coin::mint_and_transfer<BOZO_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BOZO_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOZO_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOZO_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

