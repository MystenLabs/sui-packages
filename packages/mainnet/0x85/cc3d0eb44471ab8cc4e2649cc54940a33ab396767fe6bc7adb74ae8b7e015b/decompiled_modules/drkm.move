module 0x85cc3d0eb44471ab8cc4e2649cc54940a33ab396767fe6bc7adb74ae8b7e015b::drkm {
    struct DRKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRKM>(arg0, 9, b"DRKM", b"DarkMaster", b"My favorite hero , My favorite token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f3f384f-03f8-41d7-9934-49bf460a8498.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRKM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRKM>>(v1);
    }

    // decompiled from Move bytecode v6
}

