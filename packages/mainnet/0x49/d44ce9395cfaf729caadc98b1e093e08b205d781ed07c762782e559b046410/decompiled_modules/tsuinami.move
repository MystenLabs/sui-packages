module 0x49d44ce9395cfaf729caadc98b1e093e08b205d781ed07c762782e559b046410::tsuinami {
    struct TSUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUINAMI>(arg0, 6, b"TSUINAMI", b"Tsuinami", b"Can't stop won't stop  Tsuinami Volume on SUI (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_23_16_58_994fcd0ea3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUINAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

