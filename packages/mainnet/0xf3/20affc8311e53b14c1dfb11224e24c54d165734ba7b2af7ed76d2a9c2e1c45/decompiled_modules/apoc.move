module 0xf320affc8311e53b14c1dfb11224e24c54d165734ba7b2af7ed76d2a9c2e1c45::apoc {
    struct APOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOC>(arg0, 9, b"APOC", b"Apocalypse", b"Safe World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bef52a72-33d7-4d4e-920d-bf2278a28199.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

