module 0xb10718d23a4bd93d03d4e5e60543bcde6124d41ce99b4e145f179ca1f87b43a5::ae {
    struct AE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AE>(arg0, 9, b"AE", b"Aireth", b"Ai and rocket technology....to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2edfd8e-d061-470d-a4c3-0ddef1771812.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AE>>(v1);
    }

    // decompiled from Move bytecode v6
}

