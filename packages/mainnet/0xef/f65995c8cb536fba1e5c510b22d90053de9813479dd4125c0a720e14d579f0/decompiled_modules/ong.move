module 0xeff65995c8cb536fba1e5c510b22d90053de9813479dd4125c0a720e14d579f0::ong {
    struct ONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONG>(arg0, 9, b"ONG", b"Oilandgas", b"First oil factory on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33c7cfb7-12e1-44e0-b261-74424efb278d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

