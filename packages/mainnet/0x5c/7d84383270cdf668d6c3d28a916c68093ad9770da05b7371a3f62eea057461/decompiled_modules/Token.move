module 0x5c7d84383270cdf668d6c3d28a916c68093ad9770da05b7371a3f62eea057461::Token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"TOKEN", b"Token", b"just a token for testing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G08DHvYbwAAmXEg?format=png&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

