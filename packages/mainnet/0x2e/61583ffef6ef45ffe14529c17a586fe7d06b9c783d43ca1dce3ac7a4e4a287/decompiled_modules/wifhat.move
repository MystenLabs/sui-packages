module 0x2e61583ffef6ef45ffe14529c17a586fe7d06b9c783d43ca1dce3ac7a4e4a287::wifhat {
    struct WIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHAT>(arg0, 9, b"WIFHAT", b"WIF", b"WIF TO THE MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e5b4c20-f122-4d58-97e5-c9f6fe8865b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

