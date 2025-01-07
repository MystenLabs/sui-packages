module 0xcd46853fb30ea5a6c0c9a97d5616e978b35650d09ff19437abf4bf81700f2a0f::garpit {
    struct GARPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARPIT>(arg0, 9, b"GARPIT", b"Garpit Sui", b"Garpit on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32120d96-34ed-444d-817b-fcfce7ea087b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

