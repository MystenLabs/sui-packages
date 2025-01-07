module 0xe13606a27569dba70ff82fb3d911044d4f14bc5b7e2e3afea716a38b247d0aa3::amhad {
    struct AMHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMHAD>(arg0, 9, b"AMHAD", b"Muhammad", b"This is so  nice coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d806bcd5-a140-4614-859d-82d44c0c9e33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

