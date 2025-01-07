module 0x19848ae22e9d198e0ea3b2dda02fea12da8890008928f2071d218a9964d30333::mex {
    struct MEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEX>(arg0, 9, b"MEX", b" Dex", b"Kex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d6d243b-012b-47e9-bb45-dcf9e202728a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

