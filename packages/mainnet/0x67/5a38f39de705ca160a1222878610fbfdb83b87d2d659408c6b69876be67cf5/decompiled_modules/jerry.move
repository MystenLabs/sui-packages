module 0x675a38f39de705ca160a1222878610fbfdb83b87d2d659408c6b69876be67cf5::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 9, b"JERRY", b"jerry", b"Get Cheesy, Get Wealthy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/302e77c7-6098-4658-b939-a326427c7708.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

