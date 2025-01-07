module 0xe4992616886337b5b62cec55ccb45386c9403fb5fd8c2cc6f9d98c9edfdef343::adxa {
    struct ADXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADXA>(arg0, 9, b"ADXA", b"AdexxyArt ", b"Power is in sight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa9a77f6-2f22-485e-b5d0-fbb64fba67d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

