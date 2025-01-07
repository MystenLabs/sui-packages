module 0x92678b6c6e82f476b70a695c44336d251b80ad118b38b966175246e846fcc2d2::ali {
    struct ALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALI>(arg0, 9, b"ALI", b"Alibabab", b"Alibaba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e371522b-b22e-4c4f-8eee-f2405272dfe6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

