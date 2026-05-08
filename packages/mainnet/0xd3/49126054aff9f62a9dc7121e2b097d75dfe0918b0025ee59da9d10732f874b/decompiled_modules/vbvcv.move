module 0xd349126054aff9f62a9dc7121e2b097d75dfe0918b0025ee59da9d10732f874b::vbvcv {
    struct VBVCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBVCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBVCV>(arg0, 6, b"VBVCV", b"aaaaaaaaa", b"SDSADSADSA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778274355901.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VBVCV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBVCV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

