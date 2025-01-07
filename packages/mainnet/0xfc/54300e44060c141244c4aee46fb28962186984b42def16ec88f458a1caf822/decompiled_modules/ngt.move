module 0xfc54300e44060c141244c4aee46fb28962186984b42def16ec88f458a1caf822::ngt {
    struct NGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGT>(arg0, 9, b"NGT", b"SJP", b"Good morning I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e2a2c9f-d0b9-4e9c-a985-0866b47d713a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

