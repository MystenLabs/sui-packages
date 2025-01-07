module 0xf63909f6f16a72bb0c0fbdce77525a713874a2b90b5b2e0c3328d52abfacb557::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUI>(arg0, 9, b"SQUI", b"Squirrel", b"Just for fun. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79dc483b-5d5b-466e-847b-3e470bfc5518.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

