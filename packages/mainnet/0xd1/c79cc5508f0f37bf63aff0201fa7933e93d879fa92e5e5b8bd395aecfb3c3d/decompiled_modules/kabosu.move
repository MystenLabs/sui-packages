module 0xd1c79cc5508f0f37bf63aff0201fa7933e93d879fa92e5e5b8bd395aecfb3c3d::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 9, b"KABOSU", b"KABOSUI", b"Kabosu, the Shiba Inu whose image became synonymous with the Dogecoin cryptocurrency and the \"Doge\" meme, passed away recently, leaving behind a legacy that transcended the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ff4d4e4-ce41-4383-9066-031b89f6c702.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

