module 0x1f85cd7d6f333f4880537d11a9ba9ba1cd696331d69325f90ec9a2540c9946b5::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACO>(arg0, 6, b"TACO", b"Burrito", b"Burrito but ticker is TACO, Send it traderrrssss. https://t.me/BurritoSui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/burrito_15816e44cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

