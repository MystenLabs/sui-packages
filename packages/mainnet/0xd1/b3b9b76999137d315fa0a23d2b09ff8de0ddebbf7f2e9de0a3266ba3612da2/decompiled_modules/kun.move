module 0xd1b3b9b76999137d315fa0a23d2b09ff8de0ddebbf7f2e9de0a3266ba3612da2::kun {
    struct KUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUN>(arg0, 9, b"KUN", b"Klunk", b"Dope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/797bb502-80d5-4125-b396-97f3464e5b9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

