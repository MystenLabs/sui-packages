module 0xd5583b35561d57fd5680de47f24785f24214a65b46ae8e00045a07824537a3e0::pxltt {
    struct PXLTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXLTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PXLTT>(arg0, 6, b"PXLTT", b"PXLTt by SuiAI", b"Ai moderator ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ava_ffe0efc31a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PXLTT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXLTT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

