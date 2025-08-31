module 0xdb6d2b57c67fc9b756d1220f56722872fff039a328ed0ff44f1c66cbb3a9e676::cicc_coin {
    struct CICC_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CICC_COIN>, arg1: 0x2::coin::Coin<CICC_COIN>) {
        0x2::coin::burn<CICC_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CICC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CICC_COIN>>(0x2::coin::mint<CICC_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CICC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CICC_COIN>(arg0, 9, b"CICC", b"CICC Coin", b"A standard fungible coin of the CICC ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ltfjtupq5ikxw5rgye5jxm7itmdsdlbucrycwhzkxo54sn7enhua.arweave.net/XMqZ0fDqFXt2JsE6m7PomwchrDQUcCsfKru7yTfkaeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CICC_COIN>>(0x2::coin::mint<CICC_COIN>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CICC_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CICC_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

