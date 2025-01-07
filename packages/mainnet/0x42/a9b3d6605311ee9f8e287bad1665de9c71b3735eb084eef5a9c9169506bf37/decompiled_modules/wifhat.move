module 0x42a9b3d6605311ee9f8e287bad1665de9c71b3735eb084eef5a9c9169506bf37::wifhat {
    struct WIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHAT>(arg0, 9, b"WIFHAT", b"WIF", b"WIF TO THE MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0913ef6-bbae-436c-9f93-e07f2f4948ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

