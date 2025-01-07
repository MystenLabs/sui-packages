module 0x2c3d30b08fd10713b589da8d2d30a9f6420fc92c51f673390b2cf98686c9bf43::babyxrp {
    struct BABYXRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYXRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYXRP>(arg0, 6, b"BabyXRP", b"bXRP", b"Baby XRP is the newest and cutest meme coin born on the Sui blockchain! Inspired by the legendary XRP but with its own playful twist, Baby XRP combines the power of blockchain innovation with the fun and engaging world of meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734399783744.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYXRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYXRP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

