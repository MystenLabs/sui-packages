module 0x2c4e31bee87c4457b56ed43a3d4a615d2f401c718b3542f193a19f9b0dd5aba7::ponkei {
    struct PONKEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKEI>(arg0, 6, b"PONKEI", b"Ponkei on Sui", b"SUIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ponkei_a5703a7749.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

