module 0x2c64a58148cf3b6e6678c522ec188589275a43fbd73fc1ded9e291261eac7dcb::fmfmf {
    struct FMFMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMFMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMFMF>(arg0, 9, b"FMFMF", b"Kfjfmfm", b"Fmfmfm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/182f7fcf-34aa-4c58-8a84-5e682addae88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMFMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMFMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

