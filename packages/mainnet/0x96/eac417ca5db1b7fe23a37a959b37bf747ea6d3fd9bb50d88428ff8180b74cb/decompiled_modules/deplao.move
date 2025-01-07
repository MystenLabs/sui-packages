module 0x96eac417ca5db1b7fe23a37a959b37bf747ea6d3fd9bb50d88428ff8180b74cb::deplao {
    struct DEPLAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPLAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPLAO>(arg0, 9, b"DEPLAO", b"deplao", b"DEPALAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7772d2df-6bdc-4166-9f29-8e46a57bd8c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPLAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPLAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

