module 0x59ba47094ab767237ce0ac0001de5426b0ef979eb8258989325719f454922ffa::pav {
    struct PAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAV>(arg0, 9, b"PAV", b"Pavlovnia", b"token wood pavlovnia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0445f7e9-8b7e-4a3f-847e-6293024e8898.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

