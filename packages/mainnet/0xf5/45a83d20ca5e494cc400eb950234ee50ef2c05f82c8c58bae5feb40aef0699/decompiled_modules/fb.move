module 0xf545a83d20ca5e494cc400eb950234ee50ef2c05f82c8c58bae5feb40aef0699::fb {
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

