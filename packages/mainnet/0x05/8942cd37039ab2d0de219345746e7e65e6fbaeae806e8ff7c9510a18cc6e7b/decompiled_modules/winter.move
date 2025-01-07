module 0x58942cd37039ab2d0de219345746e7e65e6fbaeae806e8ff7c9510a18cc6e7b::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"WINTER", b"Winter Dolphin", b"Rescued on December 10, 2005, after becoming entangled in a crab trap, Winter lost most of her tail due to severe injuries. This caused her to swim abnormally, moving her tail side to side.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968289816.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

