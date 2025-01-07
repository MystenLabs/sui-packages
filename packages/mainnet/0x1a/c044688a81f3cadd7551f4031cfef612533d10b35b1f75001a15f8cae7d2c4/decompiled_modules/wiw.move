module 0x1ac044688a81f3cadd7551f4031cfef612533d10b35b1f75001a15f8cae7d2c4::wiw {
    struct WIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIW>(arg0, 9, b"WIW", b"Wiwi", b"Wiwi is a meme token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/468d1069-b034-4c8f-9e12-b35cb769c125.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

