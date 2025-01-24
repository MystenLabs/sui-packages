module 0x23556c67214d2598988bc2a214ffa7e04a3a8f1ae6a33736f866efcd9b5a713a::catgpt {
    struct CATGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATGPT>(arg0, 6, b"CATGPT", b"CatGPT by SuiAI", b"A cute cat with big hopes and dreams, if the community can get behind it enough ill give it a twitter and tg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/catgpt_9ad5f0a003.bin")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATGPT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGPT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

