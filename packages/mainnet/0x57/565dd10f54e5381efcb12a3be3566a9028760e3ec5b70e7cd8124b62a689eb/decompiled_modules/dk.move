module 0x57565dd10f54e5381efcb12a3be3566a9028760e3ec5b70e7cd8124b62a689eb::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DK>(arg0, 9, b"DK", b"Duck", b"Love duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68f443e7-de0e-4f23-8c67-8eaa0bb4287b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DK>>(v1);
    }

    // decompiled from Move bytecode v6
}

