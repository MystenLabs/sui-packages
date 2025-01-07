module 0x28b5173954ea844fc1851c39604c5aacc751a293b7bd46300ba1165cf74f6035::ehe {
    struct EHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHE>(arg0, 9, b"EHE", b"EHEE", b"HEHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4c3a132-0cc9-43be-b27f-5c157249612d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

