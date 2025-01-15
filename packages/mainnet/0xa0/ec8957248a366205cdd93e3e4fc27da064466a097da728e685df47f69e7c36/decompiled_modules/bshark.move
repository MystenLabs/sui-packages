module 0xa0ec8957248a366205cdd93e3e4fc27da064466a097da728e685df47f69e7c36::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BullShark AI by SuiAI", x"f09f9a8020416476616e63656420536e6970657220426f74202b20f09fa496204149204167656e74202b20f09f96bc2044796e616d696320504650204e4654732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/XZ_Lwqlj_H_400x400_606fbd030e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSHARK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

