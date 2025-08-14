module 0xb3f3d1c0a8139f7611c2d51bbb34b8bb65a638b13105e369ee52666485f486aa::suimooner {
    struct SUIMOONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOONER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOONER>(arg0, 6, b"SuiMooner", b"SuiMooners", b"Alpha Group", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiclyjq4xatx7ow4jaos4ta2tdiw4zawzl4lptglsoj7guvxixsqoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOONER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMOONER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

