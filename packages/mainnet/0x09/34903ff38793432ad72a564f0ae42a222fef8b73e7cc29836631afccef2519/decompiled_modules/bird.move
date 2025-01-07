module 0x934903ff38793432ad72a564f0ae42a222fef8b73e7cc29836631afccef2519::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 9, b"BIRD", b"BIRDCAM", b"BOT BIRD CAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8dcb63e3-cbcf-4ebe-9fe6-0edb7e34ef7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

