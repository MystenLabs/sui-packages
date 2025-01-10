module 0xd855f2ea927797b5b4fd926b971cc66e4273927f2a4bbcb8885bf2e7ba1ebde::guid {
    struct GUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUID>(arg0, 9, b"GUID", b"uid", b"guid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6080fc49-e6f0-4069-84ea-73648b6a8580.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

