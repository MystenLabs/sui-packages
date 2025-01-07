module 0x10a1405f2aa45a3f6eb8f11c8a56d4cedc91d4eb52074a3048a2743c876a96f4::kati {
    struct KATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATI>(arg0, 9, b"KATI", b"Katikati", b"Dancing stuff ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90f96f80-1055-4c73-b732-5064b871ae1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

