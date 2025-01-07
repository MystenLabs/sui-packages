module 0x4d437f741ec05550cad5e917997dcdbbf8159c368bb681783e0575b71147307b::pu {
    struct PU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PU>(arg0, 9, b"PU", b"PuPu", b"Just pu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cd5135d-8f52-4152-829a-d3433698af4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PU>>(v1);
    }

    // decompiled from Move bytecode v6
}

