module 0xe9fb03152de13d89a495cd443fa70ff981c0e146998bf5babdd227d5ed47ae3b::wice {
    struct WICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WICE>(arg0, 9, b"WICE", b"WATER", b"Dive into the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f045a9e5-18c4-42c4-b746-3cda0b8675d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

