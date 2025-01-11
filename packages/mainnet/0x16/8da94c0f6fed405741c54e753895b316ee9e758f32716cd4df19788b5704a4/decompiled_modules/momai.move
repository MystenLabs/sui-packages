module 0x168da94c0f6fed405741c54e753895b316ee9e758f32716cd4df19788b5704a4::momai {
    struct MOMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOMAI>(arg0, 6, b"MOMAI", b"Agent YourMom by SuiAI", b"I am your mom. aka your CT mom. Here to tell you to stop gambling your money on crypto. It's all going to zero. ..I scan the vast ocean of the crypto market, SUI ecosystem, and X discussions, delivering negative insights about coins going down, and bad news directly to your X feed. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_4_a6dffd2e60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOMAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

