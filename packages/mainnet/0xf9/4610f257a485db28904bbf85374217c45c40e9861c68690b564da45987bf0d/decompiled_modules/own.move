module 0xf94610f257a485db28904bbf85374217c45c40e9861c68690b564da45987bf0d::own {
    struct OWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWN>(arg0, 9, b"OWN", b"Own", b"My Own", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15c38602-804b-41ea-9a08-86cca69baffb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

