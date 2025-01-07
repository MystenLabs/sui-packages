module 0x63378a74005bb56281ea31c91fe13af15d813d1a11b5122f01e1d49163e66a9a::om {
    struct OM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OM>(arg0, 9, b"OM", b"Omnom", b"Om nom nom nom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4111d4a-adc7-459b-8740-997e33994d0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OM>>(v1);
    }

    // decompiled from Move bytecode v6
}

