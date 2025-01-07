module 0x9bf92cc8567cbccecdfd7106a9565b14cd487bd2937cbd4cee9f9af1d3ea714a::trumplambo {
    struct TRUMPLAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLAMBO>(arg0, 6, b"TRUMPLAMBO", b"Trump Lambo", b"Trump Lambo is the Best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731424528996.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

