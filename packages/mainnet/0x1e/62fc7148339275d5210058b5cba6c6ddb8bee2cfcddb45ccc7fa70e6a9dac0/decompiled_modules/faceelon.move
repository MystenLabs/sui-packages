module 0x1e62fc7148339275d5210058b5cba6c6ddb8bee2cfcddb45ccc7fa70e6a9dac0::faceelon {
    struct FACEELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACEELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACEELON>(arg0, 9, b"FACEELON", b"Face", b"Face to Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81eaa83a-8179-40d6-9270-4b344b5f3491.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACEELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACEELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

