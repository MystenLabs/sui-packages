module 0x2a1daa853b149f2e9b440d73ce04e4e8f0d925e33137d67915cd75952b5796e1::suimew {
    struct SUIMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEW>(arg0, 9, b"SUIMEW", b"sMew", b"Mew on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32b734a3-1417-4d38-aad5-1c45b805f97b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

