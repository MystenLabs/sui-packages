module 0x45aaa322b8e56e309f9e338d016a1001ee1900cf870998f51a102189b57f89ab::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 9, b"CT", b"Cati ", b"Lodding ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e2d3861-f337-4926-ad27-a49f1c1986b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT>>(v1);
    }

    // decompiled from Move bytecode v6
}

