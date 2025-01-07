module 0x8c439f4e9dc36713984478177ed5514da32e92fd1c3d5660affaf43d1a78ce35::gau {
    struct GAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAU>(arg0, 9, b"GAU", b"MINIDOG", b"mischievous adorable dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54c51552-0016-4910-a5a3-0500d65a6fbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

