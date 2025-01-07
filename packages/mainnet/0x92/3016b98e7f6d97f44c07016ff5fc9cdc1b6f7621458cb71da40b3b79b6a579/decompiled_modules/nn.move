module 0x923016b98e7f6d97f44c07016ff5fc9cdc1b6f7621458cb71da40b3b79b6a579::nn {
    struct NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NN>(arg0, 9, b"NN", b"Nina", b"Tyu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/717b9605-5cf0-4a73-8379-0cc81d0da636.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NN>>(v1);
    }

    // decompiled from Move bytecode v6
}

