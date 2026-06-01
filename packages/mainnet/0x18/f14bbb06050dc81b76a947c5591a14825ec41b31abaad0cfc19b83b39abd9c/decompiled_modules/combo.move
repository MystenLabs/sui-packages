module 0x18f14bbb06050dc81b76a947c5591a14825ec41b31abaad0cfc19b83b39abd9c::combo {
    struct COMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMBO>(arg0, 9, b"COMBO", b"COMBO", b"Combo coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/thumbnails/041/444/729/small/ai-generated-fresh-organic-potatoe-with-potato-slice-isolated-healthy-and-organic-food-ai-generated-transparent-with-shadow-png.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMBO>>(v1);
    }

    // decompiled from Move bytecode v7
}

