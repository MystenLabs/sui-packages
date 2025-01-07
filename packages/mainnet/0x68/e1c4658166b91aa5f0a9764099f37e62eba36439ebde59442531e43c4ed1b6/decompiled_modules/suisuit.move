module 0x68e1c4658166b91aa5f0a9764099f37e62eba36439ebde59442531e43c4ed1b6::suisuit {
    struct SUISUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUIT>(arg0, 6, b"SUISUIT", b"SUIT", b"The SUI SUIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suit_8c9e255ab1.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

