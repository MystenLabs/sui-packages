module 0xadf763489ac2b60a78bef7532bfe8021d09f4b9babba6ed85b1ac4775fb7eb40::khamaaas {
    struct KHAMAAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAMAAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAMAAAS>(arg0, 6, b"Khamaaas", b"Khamaas", b"Do you condemn KHAAAMAS???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3063_1870d8c5b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAMAAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAMAAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

