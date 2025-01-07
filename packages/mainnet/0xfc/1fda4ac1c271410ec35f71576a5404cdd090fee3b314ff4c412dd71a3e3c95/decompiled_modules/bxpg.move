module 0xfc1fda4ac1c271410ec35f71576a5404cdd090fee3b314ff4c412dd71a3e3c95::bxpg {
    struct BXPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BXPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BXPG>(arg0, 6, b"BXPG", b"BuxPugz", b"This pug knows how to hustle and dance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733045341108.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BXPG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BXPG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

