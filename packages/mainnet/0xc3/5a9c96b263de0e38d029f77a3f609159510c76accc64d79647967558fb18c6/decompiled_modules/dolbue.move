module 0xc35a9c96b263de0e38d029f77a3f609159510c76accc64d79647967558fb18c6::dolbue {
    struct DOLBUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLBUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLBUE>(arg0, 6, b"DOLBUE", b"Dolbue", b"DOLBUE  was born at the right moment with a community that continues to grow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052247_ea131244e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLBUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLBUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

