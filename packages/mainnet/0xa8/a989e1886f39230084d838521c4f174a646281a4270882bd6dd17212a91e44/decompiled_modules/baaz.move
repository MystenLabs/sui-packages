module 0xa8a989e1886f39230084d838521c4f174a646281a4270882bd6dd17212a91e44::baaz {
    struct BAAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAAZ>(arg0, 9, b"BAAZ", b"Shabaazz", b"Freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d1838ed-23cc-4f70-92b0-619268293be0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

