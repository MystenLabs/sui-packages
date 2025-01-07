module 0x83691267d357d78a47f79b89bb1acc9057fdc0a85ffbd379a07c4567bd77aef8::hamid {
    struct HAMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMID>(arg0, 9, b"HAMID", b"Abdul ", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02e764aa-21a0-4008-bcdf-74ffc88a7e21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMID>>(v1);
    }

    // decompiled from Move bytecode v6
}

