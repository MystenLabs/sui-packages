module 0x7cdf63d8309a611944aebac4761a7b5ea26466be7c8422cb723e7314b79b0a56::vini7 {
    struct VINI7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINI7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINI7>(arg0, 9, b"VINI7", b"Vini7", b"Inspired by Vinicius Jr amazing form this season ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/060e55b4-5224-465a-a83c-e63ef5ebf244.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINI7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINI7>>(v1);
    }

    // decompiled from Move bytecode v6
}

