module 0xd739286c89aa2ed32f8598b094ac55d8d68f2e8581582c5ff435f52a0f640651::bobk {
    struct BOBK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBK>(arg0, 6, b"BOBK", b"BOOK OF BATCAT", b"BOBK JUST DROPPED ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_3512795e66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBK>>(v1);
    }

    // decompiled from Move bytecode v6
}

