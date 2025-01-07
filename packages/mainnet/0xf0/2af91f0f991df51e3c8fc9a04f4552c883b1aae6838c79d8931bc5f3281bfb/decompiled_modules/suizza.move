module 0xf02af91f0f991df51e3c8fc9a04f4552c883b1aae6838c79d8931bc5f3281bfb::suizza {
    struct SUIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZA>(arg0, 6, b"SUIZZA", b"PIZZA INSIDA A BANANA", b"sucks to be a pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d727add33f103ab475cdeb8723864641_1ca43e8e90.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

