module 0xaed37deef9e4ae33e2f6063b0d29f9f3cda60cb73c7133964a482f8f6804227e::haaka {
    struct HAAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAAKA>(arg0, 9, b"HAAKA", b"Koi Shark", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ecf3e5b-cbe0-402e-801c-4be9bd46f1b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

