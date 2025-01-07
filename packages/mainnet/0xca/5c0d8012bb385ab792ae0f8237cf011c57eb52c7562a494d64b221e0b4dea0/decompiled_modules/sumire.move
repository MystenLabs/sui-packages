module 0xca5c0d8012bb385ab792ae0f8237cf011c57eb52c7562a494d64b221e0b4dea0::sumire {
    struct SUMIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMIRE>(arg0, 6, b"SUMIRE", b"Sumire", b"The Cutest Dog Has Arrived On Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xwaxwaxwa_c64dba1754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

