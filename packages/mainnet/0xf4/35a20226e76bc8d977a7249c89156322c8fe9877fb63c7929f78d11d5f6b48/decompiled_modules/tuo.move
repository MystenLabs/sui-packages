module 0xf435a20226e76bc8d977a7249c89156322c8fe9877fb63c7929f78d11d5f6b48::tuo {
    struct TUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUO>(arg0, 9, b"TUO", b"FFWGA", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad07aed0-535b-444f-88ba-4e0a55dd64a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

