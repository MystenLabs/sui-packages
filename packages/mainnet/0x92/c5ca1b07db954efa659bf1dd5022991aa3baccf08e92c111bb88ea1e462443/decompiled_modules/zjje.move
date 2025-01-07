module 0x92c5ca1b07db954efa659bf1dd5022991aa3baccf08e92c111bb88ea1e462443::zjje {
    struct ZJJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZJJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZJJE>(arg0, 9, b"ZJJE", b"hkn", b"ghk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60626eb5-c108-454d-bd97-f9c1865647a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZJJE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZJJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

