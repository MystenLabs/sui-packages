module 0x1286b538d7eb404d099f4c1173aee57b28b4683b76a1a94d02ea918068603b6f::wawe {
    struct WAWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWE>(arg0, 9, b"WAWE", b"Wawe og", b"Real wawe og", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e26973fb-a295-47f3-b794-163166097fe2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

