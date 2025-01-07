module 0x8a087cb0a890d582f6f088c6a932e61315b5f75f67cec086ed305108e2fa165::rising {
    struct RISING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISING>(arg0, 9, b"RISING", b"RISINGS", b"RISING ROCKET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/871a5361-cb40-456e-9b38-4040bb9923b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RISING>>(v1);
    }

    // decompiled from Move bytecode v6
}

