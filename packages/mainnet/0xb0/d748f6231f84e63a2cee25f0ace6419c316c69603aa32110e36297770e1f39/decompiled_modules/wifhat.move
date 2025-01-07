module 0xb0d748f6231f84e63a2cee25f0ace6419c316c69603aa32110e36297770e1f39::wifhat {
    struct WIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHAT>(arg0, 9, b"WIFHAT", b"WIF", b"WIF TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a78445dd-9711-4922-9bcb-67d3ce12bfa5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

