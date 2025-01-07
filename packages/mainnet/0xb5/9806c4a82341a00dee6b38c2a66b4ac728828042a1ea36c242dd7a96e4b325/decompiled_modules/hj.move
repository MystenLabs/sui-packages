module 0xb59806c4a82341a00dee6b38c2a66b4ac728828042a1ea36c242dd7a96e4b325::hj {
    struct HJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJ>(arg0, 9, b"HJ", b"FDH", b"MG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d94c35a4-6b68-4310-a677-0a41fce4c2da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

