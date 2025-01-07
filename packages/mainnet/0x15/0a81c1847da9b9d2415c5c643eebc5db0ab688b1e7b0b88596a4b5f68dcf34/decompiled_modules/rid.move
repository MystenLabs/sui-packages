module 0x150a81c1847da9b9d2415c5c643eebc5db0ab688b1e7b0b88596a4b5f68dcf34::rid {
    struct RID has drop {
        dummy_field: bool,
    }

    fun init(arg0: RID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RID>(arg0, 9, b"RID", b"Tricky ", b"I am not a fan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ed31f90-891e-4117-a147-8fcad1be308d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RID>>(v1);
    }

    // decompiled from Move bytecode v6
}

