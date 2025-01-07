module 0x73186bce704d42929744efa73bcba265cf7c51c7a221f675d3ea181c840be9::yijg {
    struct YIJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIJG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIJG>(arg0, 9, b"YIJG", b"Wave", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b9461e3-7e8d-4a49-9ff6-e552ceb85d7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIJG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIJG>>(v1);
    }

    // decompiled from Move bytecode v6
}

