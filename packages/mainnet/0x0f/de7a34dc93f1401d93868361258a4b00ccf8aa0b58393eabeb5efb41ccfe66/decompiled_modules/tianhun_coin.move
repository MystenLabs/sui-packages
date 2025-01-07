module 0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin {
    struct TIANHUN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIANHUN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIANHUN_COIN>(arg0, 9, b"THC", b"Tian-HunCoin", b"This is a coin for Tian-Hun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/22492312?v=4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIANHUN_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIANHUN_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIANHUN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TIANHUN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

