module 0x7565ee261d345e3ee38554f515ca08951b22dece17db1f61b80cf43a4891ea6d::cafein {
    struct CAFEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAFEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAFEIN>(arg0, 9, b"CAFEIN", b"Cafein", x"456e6a6f7920796f7572206361666520e29895207769746820f09faa9943414645494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86674499-ca9c-4cb6-befc-7dde136c3dcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAFEIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAFEIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

