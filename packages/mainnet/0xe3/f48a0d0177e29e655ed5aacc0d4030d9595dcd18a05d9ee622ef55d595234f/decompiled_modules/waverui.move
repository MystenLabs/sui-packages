module 0xe3f48a0d0177e29e655ed5aacc0d4030d9595dcd18a05d9ee622ef55d595234f::waverui {
    struct WAVERUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVERUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVERUI>(arg0, 9, b"WAVERUI", b"Rui", b"A growing platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f9fe450-5c37-4f67-a61d-7b25c2a70949.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVERUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVERUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

