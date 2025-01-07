module 0x4be563875a2d21392546fe014367bcc1fccbcebd53c517f09cc03d08574e2a57::ssdg {
    struct SSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSDG>(arg0, 9, b"SSDG", b"SmartDoggy", b"SmartDoggy is a memecoin on Sui network inspired by activeness character of dogs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73619327-a4e5-4195-a6e9-77a98eb240ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

