module 0xda15acbfd8fdbab7f4efada7d53487ccd30df338a626fbaba464c14075cd4325::hosui {
    struct HOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HOSUI>(arg0, 6, b"HOSUI", b"House of SUI", b"House of SUI, the coziest 50M MC meme home on SUI. Only community! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/HOSUI_bedc3f5d5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

