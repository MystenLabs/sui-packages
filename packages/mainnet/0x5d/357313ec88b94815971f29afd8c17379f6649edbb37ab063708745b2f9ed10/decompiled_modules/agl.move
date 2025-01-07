module 0x5d357313ec88b94815971f29afd8c17379f6649edbb37ab063708745b2f9ed10::agl {
    struct AGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGL>(arg0, 9, b"AGL", b"RWF", b"If you have any questions or ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b1d1741-3242-44da-b893-34ce9a8545fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

