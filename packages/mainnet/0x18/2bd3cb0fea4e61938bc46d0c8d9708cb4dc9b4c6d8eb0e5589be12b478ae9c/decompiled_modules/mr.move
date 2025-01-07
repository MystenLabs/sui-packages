module 0x182bd3cb0fea4e61938bc46d0c8d9708cb4dc9b4c6d8eb0e5589be12b478ae9c::mr {
    struct MR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR>(arg0, 9, b"MR", b"Wave", b"Wavememe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6356a849-eaa2-4765-8342-850a2dc1a745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MR>>(v1);
    }

    // decompiled from Move bytecode v6
}

