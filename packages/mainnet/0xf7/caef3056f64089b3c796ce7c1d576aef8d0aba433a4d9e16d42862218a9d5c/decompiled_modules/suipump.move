module 0xf7caef3056f64089b3c796ce7c1d576aef8d0aba433a4d9e16d42862218a9d5c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"SUICA", b"Suica The Rabbit", b"JrEast mascot living on sui, join the train!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/sB5IZ9e.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPUMP>>(v2);
    }

    // decompiled from Move bytecode v7
}

