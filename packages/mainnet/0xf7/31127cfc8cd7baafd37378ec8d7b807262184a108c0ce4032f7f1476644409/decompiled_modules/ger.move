module 0xf731127cfc8cd7baafd37378ec8d7b807262184a108c0ce4032f7f1476644409::ger {
    struct GER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GER>(arg0, 9, b"GER", b"Nigg", b"Bu 5k$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3419551a-2c50-4528-bc28-859dd885c33f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GER>>(v1);
    }

    // decompiled from Move bytecode v6
}

