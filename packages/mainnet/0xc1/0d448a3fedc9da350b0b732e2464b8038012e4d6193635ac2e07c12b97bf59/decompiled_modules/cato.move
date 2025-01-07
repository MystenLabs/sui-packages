module 0xc10d448a3fedc9da350b0b732e2464b8038012e4d6193635ac2e07c12b97bf59::cato {
    struct CATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATO>(arg0, 9, b"CATO", b"ORANGECAT", b"Aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4cfd5e0-56f5-4047-a1a7-3e0f844e53d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

