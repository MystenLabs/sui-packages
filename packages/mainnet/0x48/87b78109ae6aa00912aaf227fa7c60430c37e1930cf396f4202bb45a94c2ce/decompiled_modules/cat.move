module 0x4887b78109ae6aa00912aaf227fa7c60430c37e1930cf396f4202bb45a94c2ce::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"CAT FACE", b"SuiEmoji Cat Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/cat.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

