module 0x74502d67e6c875bb07bd5e5e284fea106f00cd95a5cfdf67d9f46e3b38e15b5f::ptk {
    struct PTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTK>(arg0, 9, b"PTK", b"PATRICK ", b"SHOP FROM PATRICK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c643128-b881-43fd-8479-e8cf95d10260.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

