module 0xc4dc98d6195b8abf8acd875b5485b6450c6b7aae172cb11dff74c0a08963399b::mememai {
    struct MEMEMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEMAI>(arg0, 9, b"MEMEMAI", b"Maioi", b"Hxjxxxjxj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c643284-84c6-4524-bb1a-c39e3a37d502.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

