module 0xdb7bee143415664beb833e9115dc12e898424e7d5e0a16737f87d6b60fbf55ed::occ {
    struct OCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCC>(arg0, 9, b"OCC", b"Ococ", b"Ococ is a lovely boy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ff25331-a121-47ef-a5c6-6c52bddc21ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

