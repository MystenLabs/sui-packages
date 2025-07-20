module 0x14e8f07a559d69169c7df4ebe8ff0df96ea321e327d1435b003ddeb032e107d1::kudai {
    struct KUDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KUDAI>(arg0, 6, b"KUDAI", b"Kudaiagent", b"@usecodesynx @suilaunchcoin @SuiAIFun Launch a project on @SuiAIFun by tagging @usecodesynx and including the project name and logo. $kudai + Kudaiagent https://t.co/H55nDtpeGg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kudai-gobujl.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KUDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

