module 0xf3380ace463042a26ef8a15765d66ea0891d966cc9fc4fc9cac2ff47f8a9e59b::esm {
    struct ESM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESM>(arg0, 9, b"ESM", b"ELYSIUM", b"Token Juggernaut Wars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6390f66-d2fc-4990-a2ab-970630b68851.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESM>>(v1);
    }

    // decompiled from Move bytecode v6
}

