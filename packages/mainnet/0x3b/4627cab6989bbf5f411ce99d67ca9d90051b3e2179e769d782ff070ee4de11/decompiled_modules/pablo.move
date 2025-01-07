module 0x3b4627cab6989bbf5f411ce99d67ca9d90051b3e2179e769d782ff070ee4de11::pablo {
    struct PABLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PABLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PABLO>(arg0, 6, b"Pablo", b"Don Pablo", b"Follow Don Pablo on his ruthless rise to the top of the memecoin charts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8e2c5a849a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PABLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PABLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

