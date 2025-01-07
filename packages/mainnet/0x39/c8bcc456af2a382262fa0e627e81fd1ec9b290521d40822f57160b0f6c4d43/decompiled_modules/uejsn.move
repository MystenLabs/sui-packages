module 0x39c8bcc456af2a382262fa0e627e81fd1ec9b290521d40822f57160b0f6c4d43::uejsn {
    struct UEJSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UEJSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UEJSN>(arg0, 9, b"UEJSN", b"sjwmb", b"ianab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97e6dc92-741d-4993-9e25-c12775604fdd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UEJSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UEJSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

