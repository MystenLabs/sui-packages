module 0x8e3d70583e18fc3e82c074eed93f387237190822040890505819567f38f0b1db::boom_x {
    struct BOOM_X has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM_X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM_X>(arg0, 9, b"BOOM_X", b"Boom X ", b"Way To Change ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c99748b9-4bcb-480c-91eb-330af6717594.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM_X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM_X>>(v1);
    }

    // decompiled from Move bytecode v6
}

