module 0x6b69b598707dd269bb667b31fded10ab619878b3fe8e8ba87db7ffcd9742e5ad::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGD>(arg0, 9, b"SGD", b"GJ", b"BXCVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6cb33ad-f8c3-496f-b880-f0d82e559a50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

