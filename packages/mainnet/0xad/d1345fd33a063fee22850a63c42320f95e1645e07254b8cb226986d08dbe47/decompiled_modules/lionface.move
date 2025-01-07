module 0xadd1345fd33a063fee22850a63c42320f95e1645e07254b8cb226986d08dbe47::lionface {
    struct LIONFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIONFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIONFACE>(arg0, 6, b"LIONFACE", b"LION", b"SuiEmoji Lion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/lionface.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIONFACE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONFACE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

