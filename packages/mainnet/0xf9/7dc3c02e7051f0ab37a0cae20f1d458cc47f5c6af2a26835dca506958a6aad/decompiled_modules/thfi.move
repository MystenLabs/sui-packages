module 0xf97dc3c02e7051f0ab37a0cae20f1d458cc47f5c6af2a26835dca506958a6aad::thfi {
    struct THFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THFI>(arg0, 9, b"THFI", b"Tahfizmtar", b"tahfi meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1549d3b2-9915-4625-a9d4-befb0cba29e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

