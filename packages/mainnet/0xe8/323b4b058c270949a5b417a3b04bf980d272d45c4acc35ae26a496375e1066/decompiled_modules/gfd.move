module 0xe8323b4b058c270949a5b417a3b04bf980d272d45c4acc35ae26a496375e1066::gfd {
    struct GFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFD>(arg0, 9, b"GFD", b"TH", b"GDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b71d7d2-be9d-4aff-a698-2711b8312b6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

