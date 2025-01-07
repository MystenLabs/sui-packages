module 0x37ec29237e679bb28e6f4a264bf318ce8a418a8f34cea018d65fd3bced321937::initial {
    struct INITIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: INITIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INITIAL>(arg0, 9, b"INITIAL", b"swat", b"My initial name is S Wa T ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5347907a-610b-48a2-b3a9-3bd222b26520.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INITIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INITIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

