module 0x221c1a51d9d0d204732573e2334ef03d2a5cdd2a936a99613026354f7a8a74a5::okb {
    struct OKB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKB>(arg0, 9, b"OKB", b"Okbro", b"Oke nha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d50817a4-c99c-44f4-9f55-143913379c24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKB>>(v1);
    }

    // decompiled from Move bytecode v6
}

