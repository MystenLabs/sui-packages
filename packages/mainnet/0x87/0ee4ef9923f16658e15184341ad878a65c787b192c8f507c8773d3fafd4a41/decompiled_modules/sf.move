module 0x870ee4ef9923f16658e15184341ad878a65c787b192c8f507c8773d3fafd4a41::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 9, b"SF", b"SilentFran", b"One of a kind ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6210138c-d419-4b08-80cb-63afa00485cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SF>>(v1);
    }

    // decompiled from Move bytecode v6
}

