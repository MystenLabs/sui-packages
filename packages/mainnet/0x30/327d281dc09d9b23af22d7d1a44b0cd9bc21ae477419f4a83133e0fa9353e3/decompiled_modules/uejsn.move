module 0x30327d281dc09d9b23af22d7d1a44b0cd9bc21ae477419f4a83133e0fa9353e3::uejsn {
    struct UEJSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UEJSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UEJSN>(arg0, 9, b"UEJSN", b"sjwmb", b"ianab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fec7918-3645-49c0-8bd8-d2339f963a87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UEJSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UEJSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

