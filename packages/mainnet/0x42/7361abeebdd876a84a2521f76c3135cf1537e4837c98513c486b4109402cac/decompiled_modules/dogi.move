module 0x427361abeebdd876a84a2521f76c3135cf1537e4837c98513c486b4109402cac::dogi {
    struct DOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGI>(arg0, 9, b"DOGI", b"Dogi", b"Dogsss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/960e79ce-f725-4ec7-aa20-f8ddd562a053.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

