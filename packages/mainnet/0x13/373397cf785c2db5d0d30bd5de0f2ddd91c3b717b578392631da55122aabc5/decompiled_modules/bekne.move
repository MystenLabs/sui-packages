module 0x13373397cf785c2db5d0d30bd5de0f2ddd91c3b717b578392631da55122aabc5::bekne {
    struct BEKNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEKNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEKNE>(arg0, 9, b"BEKNE", b"hejwns", b"bene", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eaccd5b2-fb4f-4e58-8a34-574ac4b2462d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEKNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEKNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

