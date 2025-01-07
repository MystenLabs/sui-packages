module 0x6930176a6c08bae6bd61b30c958ab27bd72e55e523a177f9f0d50e71bc1af8e4::tfl {
    struct TFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFL>(arg0, 9, b"TFL", b"TULIPFLOW", x"5374756e6e696e67206272616e64696e67207769746820612074756c6970207468656d650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/223a152a-fb4d-4610-8ddc-419ce126f8e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

