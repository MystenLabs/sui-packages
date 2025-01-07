module 0x4ce708cf5a7716870808d02a69b95903b4d7aa719225552843b6fdb97aa0b049::whalesui {
    struct WHALESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALESUI>(arg0, 6, b"Whalesui", b"Whalesyi", x"45766572796f6e6520697320245748414c455355492068657265210a0a68747470733a2f2f6c696e6b74722e65652f7768616c6563756d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000262211_9fc5cb4efe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

