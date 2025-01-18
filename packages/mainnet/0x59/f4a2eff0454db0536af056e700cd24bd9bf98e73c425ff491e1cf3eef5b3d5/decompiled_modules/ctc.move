module 0x59f4a2eff0454db0536af056e700cd24bd9bf98e73c425ff491e1cf3eef5b3d5::ctc {
    struct CTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CTC>(arg0, 6, b"CTC", b"COMMUNITY TRUMP COIN by SuiAI", b"COMMUNITY TRUMP ($CT), the community coin for the greatest President! Launch supply all goes to the president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/55_1e79bc8b90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

