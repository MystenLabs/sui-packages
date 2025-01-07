module 0x4fb2533b92cc0a00818c94cc632215c5312ac19c93dbab35e16aaa3b9ff26efe::devil {
    struct DEVIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVIL>(arg0, 9, b"DEVIL", b"Meow", b"The Devil Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b654ae2-d740-4b5e-bfa8-2c80c4b8c1ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

