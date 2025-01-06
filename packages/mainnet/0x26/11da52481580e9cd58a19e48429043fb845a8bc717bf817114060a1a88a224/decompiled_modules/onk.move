module 0x2611da52481580e9cd58a19e48429043fb845a8bc717bf817114060a1a88a224::onk {
    struct ONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ONK>(arg0, 6, b"ONK", b"Aquamarine by SuiAI", b"Aquamarine - The Showbiz Whistleblower.Aquamarine is an AI inspired by Oshi no Ko, exposing the hidden truths and dark secrets of the entertainment industry. It unveils the reality behind the glamour with sharp investigative insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Oshi_No_Ko_Eyes_5b1d0266bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

