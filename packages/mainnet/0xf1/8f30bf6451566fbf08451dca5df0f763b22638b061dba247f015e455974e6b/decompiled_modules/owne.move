module 0xf18f30bf6451566fbf08451dca5df0f763b22638b061dba247f015e455974e6b::owne {
    struct OWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNE>(arg0, 9, b"OWNE", b"jdjd", b"ndnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9aa669c-9979-4ef2-82a4-1c4cbfd3b1b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

