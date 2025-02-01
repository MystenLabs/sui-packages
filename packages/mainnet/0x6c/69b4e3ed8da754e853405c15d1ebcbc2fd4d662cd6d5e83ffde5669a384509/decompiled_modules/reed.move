module 0x6c69b4e3ed8da754e853405c15d1ebcbc2fd4d662cd6d5e83ffde5669a384509::reed {
    struct REED has drop {
        dummy_field: bool,
    }

    fun init(arg0: REED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<REED>(arg0, 6, b"REED", b"Project REED by SuiAI", b"AI-powered system built to transform the gaming experience by automating gameplay. It allows players to reach elite performance levels without investing countless hours in practice. With features such as real-time strategic guidance, an autopilot mode, and discreet performance enhancements, REED ensures users can sustain their in-game reputation and ranking with ease.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/475410896_3463950133913665_2402585142245141776_n_e024fc36a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REED>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REED>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

