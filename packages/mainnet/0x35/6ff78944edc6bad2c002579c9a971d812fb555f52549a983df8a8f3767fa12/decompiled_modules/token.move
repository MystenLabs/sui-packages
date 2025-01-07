module 0x356ff78944edc6bad2c002579c9a971d812fb555f52549a983df8a8f3767fa12::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun img_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 1, b"TOKEN", b"TOKEN TOKEN", b"TOKEN", 0x1::option::some<0x2::url::Url>(img_url(b"https://dictionary.cambridge.org/images/thumb/token_noun_004_2618.jpg?version=5.0.316")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 100, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

