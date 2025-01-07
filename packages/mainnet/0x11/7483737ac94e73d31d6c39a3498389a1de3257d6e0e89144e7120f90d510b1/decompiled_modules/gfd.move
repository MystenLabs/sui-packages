module 0x117483737ac94e73d31d6c39a3498389a1de3257d6e0e89144e7120f90d510b1::gfd {
    struct GFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFD>(arg0, 9, b"GFD", b"GDSA", b"B VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b201d5c-4f66-4977-b637-3624a58eb138.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

