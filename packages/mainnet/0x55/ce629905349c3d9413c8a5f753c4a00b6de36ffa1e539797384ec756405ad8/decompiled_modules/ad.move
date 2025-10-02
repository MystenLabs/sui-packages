module 0x55ce629905349c3d9413c8a5f753c4a00b6de36ffa1e539797384ec756405ad8::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 6, b"AD", b"Andrew ", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759400146770.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

