module 0xa8ff4ee8d24cd2bb8358d1520ccb1b7ff0e092c273ef255e4d8086c00ea81f57::tolol {
    struct TOLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLOL>(arg0, 9, b"TOLOL", b"tolol ", b"just idiot bump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9d7ffe5-39f5-4d33-9b3a-395ae7362630.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

