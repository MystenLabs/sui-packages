module 0xf4e3e8528d609ac795775364475cd9aff497dc48f8ee08a2f29b1978eadb4656::spacat {
    struct SPACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACAT>(arg0, 9, b"SPACAT", b"SapaCat", b"misery arrow problem youth together empty original elephant antique spider remind stamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecbe3d8d-3375-46f2-a6f0-cc412891b3c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

