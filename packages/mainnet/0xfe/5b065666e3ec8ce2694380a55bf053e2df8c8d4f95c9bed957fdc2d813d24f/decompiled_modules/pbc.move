module 0xfe5b065666e3ec8ce2694380a55bf053e2df8c8d4f95c9bed957fdc2d813d24f::pbc {
    struct PBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBC>(arg0, 9, b"PBC", b"Pretty Bug", x"41206d656d6520666f72206f757220e2809c50726574747920427567e2809d2067616d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec369bc6-a614-449a-a921-66d2738bd926.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

