module 0x363bf0e00506dd1793c840a0d88ceb7e05dae8953c55a695c3a6f6133089fc23::fb {
    struct FB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FB>(arg0, 6, b"FB", b"FAKEBOOK", b"A meme coin is dedicated to the incredible SUI team, composed of many ex-Facebook visionaries! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FAKEBOOK_L1_62c58d2d90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FB>>(v1);
    }

    // decompiled from Move bytecode v6
}

