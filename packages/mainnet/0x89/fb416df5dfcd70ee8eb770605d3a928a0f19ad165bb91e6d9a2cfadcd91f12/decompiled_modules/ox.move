module 0x89fb416df5dfcd70ee8eb770605d3a928a0f19ad165bb91e6d9a2cfadcd91f12::ox {
    struct OX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OX>(arg0, 6, b"OX", b"OX", b"SuiEmoji Ox", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/ox.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

