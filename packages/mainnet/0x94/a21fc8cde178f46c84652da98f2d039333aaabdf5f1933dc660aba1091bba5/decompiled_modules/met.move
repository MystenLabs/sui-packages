module 0x94a21fc8cde178f46c84652da98f2d039333aaabdf5f1933dc660aba1091bba5::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 9, b"MET", b"METCOIN", b"A token based on a real person", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79d01b8d-c135-4c90-8d69-c2d94a3bad95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}

