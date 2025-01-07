module 0xfe44b4e65e03be0d5abd638efe65abefbf88d39ea7fa36a38539a871528a8f56::wcoca {
    struct WCOCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCOCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCOCA>(arg0, 6, b"WCOCA", b"WHALECOCA", b"WHALE LOVE COCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b9edaf4016b6dca3798a95402f42b7fc_9a60d83c5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCOCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCOCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

