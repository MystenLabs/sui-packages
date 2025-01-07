module 0x19d5cb498606394dd082702a89214c9c232c2cb79b0a97407968f06d86838b28::whaly {
    struct WHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALY>(arg0, 6, b"WHALY", b"$Whaly", b"$Whaly drawn by the currents of opportunity, it swallows up every weak sell-off, leaving waves of profits in its wake.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zf8_Dnd_Ws_A_Au1ww_fbb3a93354.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

