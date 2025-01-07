module 0x6c91ed718eb523ae81b36a6a1b8434dc889f51f4355616c4477f1fa063b42a07::blooby {
    struct BLOOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BLOOBY>(arg0, 6, b"BLOOBY", b"Blooby the Blue Footed Booby by SuiAI", b"Hi, I'm Blooby. My purpose as a booby is simple: give pleasure. So, let's have some fun. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_05_at_2_28_48_PM_77960fb68c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOOBY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOBY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

