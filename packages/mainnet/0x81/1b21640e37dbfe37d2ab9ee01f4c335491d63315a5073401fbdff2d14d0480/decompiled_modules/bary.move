module 0x811b21640e37dbfe37d2ab9ee01f4c335491d63315a5073401fbdff2d14d0480::bary {
    struct BARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARY>(arg0, 9, b"BARY", b"WEMABARY", b"WEMABARY is a meme is for the community and community alone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d685b42a-0389-4ec6-99fc-6bda07d90587.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

