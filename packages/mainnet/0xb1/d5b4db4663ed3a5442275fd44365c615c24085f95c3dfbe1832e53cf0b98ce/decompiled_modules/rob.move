module 0xb1d5b4db4663ed3a5442275fd44365c615c24085f95c3dfbe1832e53cf0b98ce::rob {
    struct ROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROB>(arg0, 9, b"ROB", b"Roben", b"Token for my fans .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb619e47-b757-4c43-9574-cc3339109c39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

