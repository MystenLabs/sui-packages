module 0xfc40ca3875da023dded7fe5dca1047f9d5c26f7a210de905757a4c519954dfe0::rirn {
    struct RIRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIRN>(arg0, 6, b"RIRN", b"Robotaxi & Robovan", b"Robotaxi & https://x.com/Tesla/status/1844583703604772893?t=BuX2tC3sowkJWWK2Mg0cuA&s=19", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018243_794a83956e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

