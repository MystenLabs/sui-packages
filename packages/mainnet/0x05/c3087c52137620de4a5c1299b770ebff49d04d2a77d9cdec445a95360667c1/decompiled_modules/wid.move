module 0x5c3087c52137620de4a5c1299b770ebff49d04d2a77d9cdec445a95360667c1::wid {
    struct WID has drop {
        dummy_field: bool,
    }

    fun init(arg0: WID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WID>(arg0, 9, b"WID", b"Dishes ", x"4920646f6ee2809974207468696e6b20736f20627574204920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/299a54c7-6f01-47b6-b55c-31cc116951bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WID>>(v1);
    }

    // decompiled from Move bytecode v6
}

