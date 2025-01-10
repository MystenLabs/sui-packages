module 0x54fecac1a674526906765254641a37f12eb945c36f1835862aa686a9d5312dfe::guid {
    struct GUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUID>(arg0, 9, b"GUID", b"uid", b"guid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13b0a51f-10eb-4064-8486-d713b13b8292.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

