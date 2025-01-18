module 0x16b3b9db39fe700e6a3165dba88d3ec9c3c86465c77569183b8363c9dacaac79::saicto {
    struct SAICTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAICTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAICTO>(arg0, 6, b"SAICTO", b"Sui AI CTO by SuiAI", b"Let's CTO this! LMAO! Build the community together with fun! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SLC_3_9485194087.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAICTO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAICTO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

