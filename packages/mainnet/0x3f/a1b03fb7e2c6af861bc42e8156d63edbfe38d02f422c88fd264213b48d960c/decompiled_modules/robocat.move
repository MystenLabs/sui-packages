module 0x3fa1b03fb7e2c6af861bc42e8156d63edbfe38d02f422c88fd264213b48d960c::robocat {
    struct ROBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOCAT>(arg0, 9, b"ROBOCAT", b"ROBO", b"Wake up ROBO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d24cf62d-5a66-45fa-9340-036c06111123.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

