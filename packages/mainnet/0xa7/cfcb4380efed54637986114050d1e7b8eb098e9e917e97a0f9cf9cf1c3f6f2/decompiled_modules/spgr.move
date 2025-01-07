module 0xa7cfcb4380efed54637986114050d1e7b8eb098e9e917e97a0f9cf9cf1c3f6f2::spgr {
    struct SPGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPGR>(arg0, 9, b"SPGR", b"Spongerice", b"Spongebob in rice shape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de03672f-728f-4ec0-bda6-8ec1f52b7cbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

