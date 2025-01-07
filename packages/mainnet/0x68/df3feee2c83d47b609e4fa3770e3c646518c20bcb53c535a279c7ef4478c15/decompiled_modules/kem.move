module 0x68df3feee2c83d47b609e4fa3770e3c646518c20bcb53c535a279c7ef4478c15::kem {
    struct KEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEM>(arg0, 9, b"KEM", b"Poodle Dog", b"My lovely poodle dog name is Kem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/991bdeb8-c11c-4c2b-86bc-9b0d39c52b45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

