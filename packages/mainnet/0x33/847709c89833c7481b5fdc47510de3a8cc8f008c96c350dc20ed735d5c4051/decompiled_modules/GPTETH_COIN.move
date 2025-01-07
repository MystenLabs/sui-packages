module 0x33847709c89833c7481b5fdc47510de3a8cc8f008c96c350dc20ed735d5c4051::GPTETH_COIN {
    struct GPTETH_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GPTETH_COIN>, arg1: 0x2::coin::Coin<GPTETH_COIN>) {
        0x2::coin::burn<GPTETH_COIN>(arg0, arg1);
    }

    fun init(arg0: GPTETH_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPTETH_COIN>(arg0, 9, b"GPTETH_COIN", b"GPTETH_COIN", b"coin create by gpteth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/71959269?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPTETH_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTETH_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GPTETH_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GPTETH_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

