module 0x25edc5f631b7cbe0652b10336fc0815d94e9db2363489050c186587c98c0bc45::tbtc {
    struct TBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBTC>(arg0, 9, b"TBTC", b"TrumpBTC", b"TrumpBtc is a memecoin designed to celebrate the victory of Donald Trump after the election. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8917e6f-3f37-4fc6-b0ff-e71d765b5cd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

