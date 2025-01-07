module 0x41743e1f1afb27706bfca797617ef0bb75e1760e1c7afd217d4ce58bcf666809::mou {
    struct MOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOU>(arg0, 9, b"MOU", b"mountain", b"mountain is big and powerful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1e6c7ae-0ddd-4576-8347-872a3b94ccbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

