module 0x612330e1762381d78e160c59d53e1d87f57bc76355bcf019c4d1134fd39519e1::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 6, b"CRASH", b"CRASH ON SUI", b"The Warren Buffet of meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_2_13e5f33d3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

