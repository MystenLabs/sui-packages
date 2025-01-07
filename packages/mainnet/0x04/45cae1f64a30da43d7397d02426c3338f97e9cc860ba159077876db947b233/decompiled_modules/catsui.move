module 0x445cae1f64a30da43d7397d02426c3338f97e9cc860ba159077876db947b233::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 9, b"CATSUI", b"CAT", x"4a7573742062757920697420616e6420796f752077696c6c20756e6465727374616e6420f09faba1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18deb30c-ac2e-4be1-899a-c6689d0db469.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

