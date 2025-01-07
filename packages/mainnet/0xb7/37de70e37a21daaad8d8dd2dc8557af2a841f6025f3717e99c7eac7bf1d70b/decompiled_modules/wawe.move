module 0xb737de70e37a21daaad8d8dd2dc8557af2a841f6025f3717e99c7eac7bf1d70b::wawe {
    struct WAWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWE>(arg0, 9, b"WAWE", b"Wawe og", b"Real wawe og", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/616a64ae-948a-4d82-a8c6-9687326cff38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

