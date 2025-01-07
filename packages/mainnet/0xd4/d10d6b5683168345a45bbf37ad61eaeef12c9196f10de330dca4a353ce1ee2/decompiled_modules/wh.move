module 0xd4d10d6b5683168345a45bbf37ad61eaeef12c9196f10de330dca4a353ce1ee2::wh {
    struct WH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WH>(arg0, 9, b"WH", b"Ag", b"Aga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2bad425-0bff-474d-aa24-fced5750ab64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WH>>(v1);
    }

    // decompiled from Move bytecode v6
}

