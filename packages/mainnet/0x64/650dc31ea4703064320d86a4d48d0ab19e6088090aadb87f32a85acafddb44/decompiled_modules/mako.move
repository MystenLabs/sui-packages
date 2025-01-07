module 0x64650dc31ea4703064320d86a4d48d0ab19e6088090aadb87f32a85acafddb44::mako {
    struct MAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKO>(arg0, 6, b"MAKO", b"Old CAT MAKO", b"old looking cat called $MAKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mako_6f9191e352.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

