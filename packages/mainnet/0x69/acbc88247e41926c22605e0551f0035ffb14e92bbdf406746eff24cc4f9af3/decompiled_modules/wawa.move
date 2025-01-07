module 0x69acbc88247e41926c22605e0551f0035ffb14e92bbdf406746eff24cc4f9af3::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWA>(arg0, 9, b"WAWA", b"Wawan", b"Wawan is the name of a popular person in Indonesia, and my name is Wawan, therefore this token was launched because I am proud to have this name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/447cb80d-ebf6-44f0-bbd8-8018c85a1c4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

