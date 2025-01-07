module 0xfc168d435804b69b50693837df02e941b1d9b272ec4349f9805ec6007eb9ca2b::bij {
    struct BIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIJ>(arg0, 9, b"BIJ", b"Joj", b"Ball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fc0194b-fd87-4ec9-9f7f-e5bc8e7505be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

