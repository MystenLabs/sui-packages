module 0xd6e8d6df53066589e3764f6badf2a37bf1829f02ad5daf743dcc7cd18a4360d3::oo7 {
    struct OO7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OO7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OO7>(arg0, 6, b"OO7", b"007", b"007 Mem Coin IFMCC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765921174030.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OO7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OO7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

