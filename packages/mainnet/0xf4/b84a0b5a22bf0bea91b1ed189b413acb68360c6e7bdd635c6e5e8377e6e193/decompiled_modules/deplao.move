module 0xf4b84a0b5a22bf0bea91b1ed189b413acb68360c6e7bdd635c6e5e8377e6e193::deplao {
    struct DEPLAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPLAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPLAO>(arg0, 9, b"DEPLAO", b"deplao", b"DEPALAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/216d0505-1ef2-427c-82ad-9f68efb8cf3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPLAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPLAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

