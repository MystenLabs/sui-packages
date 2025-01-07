module 0x8de80956373759e63742982e741d967b5d79f9262aef82c45154cab61287e25d::wcatu {
    struct WCATU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCATU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCATU>(arg0, 9, b"WCATU", b"WeweCatu", b"WeweCatu is not just memecoin,its a special memecoin that can pump as you dream in your childhood stories.so hope you will have great time with this chance of takeoff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2cba38e6-12ea-401b-8901-7fe017df4ea0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCATU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCATU>>(v1);
    }

    // decompiled from Move bytecode v6
}

