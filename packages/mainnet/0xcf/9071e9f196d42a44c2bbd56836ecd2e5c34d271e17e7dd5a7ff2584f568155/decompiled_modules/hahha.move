module 0xcf9071e9f196d42a44c2bbd56836ecd2e5c34d271e17e7dd5a7ff2584f568155::hahha {
    struct HAHHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHHA>(arg0, 9, b"HAHHA", b"Hanna", b"Sdx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/551bb97a-c374-49ad-9840-d7128bc5d4ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

