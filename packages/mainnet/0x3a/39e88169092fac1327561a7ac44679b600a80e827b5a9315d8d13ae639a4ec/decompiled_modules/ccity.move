module 0x3a39e88169092fac1327561a7ac44679b600a80e827b5a9315d8d13ae639a4ec::ccity {
    struct CCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCITY>(arg0, 9, b"CCITY", b"CITY", b"THE CITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab98fe2b-df0a-4464-99f5-bca888fc4d9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

