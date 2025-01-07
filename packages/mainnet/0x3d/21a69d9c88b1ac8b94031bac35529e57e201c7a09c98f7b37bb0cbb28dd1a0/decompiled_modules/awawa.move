module 0x3d21a69d9c88b1ac8b94031bac35529e57e201c7a09c98f7b37bb0cbb28dd1a0::awawa {
    struct AWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAWA>(arg0, 9, b"AWAWA", b"Nukawa", b"it's very funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c6fa192-df58-4a24-bbd7-6ba81daf49ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

