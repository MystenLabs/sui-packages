module 0x21464c68d282e52dd08abfd68c05166c93f9880706411721021610054a28cb3b::mtk {
    struct MTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTK>(arg0, 9, b"MTK", b"Mytoken", x"e2809c4d79546f6b656e2069732061206469676974616c2061737365742064657369676e656420746f20626520757365642077697468696e20746865204d7950726f6a6563742065636f73797374656d20666f7220726577617264696e6720757365727320616e6420666163696c69746174696e67207472616e73616374696f6e732e2049742061696d7320746f2070726f76696465206120646563656e7472616c697a656420736f6c7574696f6e20666f72206f757220636f6d6d756e6974792ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5eb16864-2051-4a6d-8275-3a9d4b69d5b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

