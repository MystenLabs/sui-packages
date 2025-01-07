module 0x8c724957d1d57ed43a4577a4186b8e4197eccd05544f709930c6c52f93ff4048::nh {
    struct NH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NH>(arg0, 9, b"NH", b"Nahuy", b"The ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0134809-2b34-4a54-905b-62431fc6671f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NH>>(v1);
    }

    // decompiled from Move bytecode v6
}

