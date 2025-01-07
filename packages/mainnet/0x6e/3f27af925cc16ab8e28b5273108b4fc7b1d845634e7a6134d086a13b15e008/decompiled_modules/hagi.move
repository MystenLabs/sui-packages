module 0x6e3f27af925cc16ab8e28b5273108b4fc7b1d845634e7a6134d086a13b15e008::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 9, b"HAGI", b"Rahagi", b"Rahagi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bef49649-49d9-4898-aafd-cf9a662cad0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

