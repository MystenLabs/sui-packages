module 0x1de8bd3bd293c975887d6fc5ab4999f10e3df1ce78d3c69b955d79af138fd57::snavy {
    struct SNAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAVY>(arg0, 6, b"SNavy", b"SUI NAVY", b"The first Navy force on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_25_10_30_32_2d8e25d3b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

