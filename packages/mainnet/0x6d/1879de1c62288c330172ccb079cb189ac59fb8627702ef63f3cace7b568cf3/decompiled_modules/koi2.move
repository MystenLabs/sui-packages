module 0x6d1879de1c62288c330172ccb079cb189ac59fb8627702ef63f3cace7b568cf3::koi2 {
    struct KOI2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI2>(arg0, 9, b"KOI2", b"Koii 2024", b"Memee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f6fa304-cb0c-4eb9-a01e-b9a0426d8dcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOI2>>(v1);
    }

    // decompiled from Move bytecode v6
}

