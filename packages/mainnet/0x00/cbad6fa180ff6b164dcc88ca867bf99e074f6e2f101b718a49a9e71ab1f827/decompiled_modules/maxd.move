module 0xcbad6fa180ff6b164dcc88ca867bf99e074f6e2f101b718a49a9e71ab1f827::maxd {
    struct MAXD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXD>(arg0, 9, b"MAXD", b"Maxdogs", b"Maxven Global Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1db736b-23b0-4d57-ac12-234826a53842.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXD>>(v1);
    }

    // decompiled from Move bytecode v6
}

