module 0x76b2bdff776eb6e1ca2683d2552b31cc73d4a6ee1544972029de8bd12c60dd43::diba {
    struct DIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIBA>(arg0, 9, b"DIBA", b"Dibacoin ", b"Family coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a50aa8d-b4ec-4555-a720-ea106b0741e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

