module 0x3cc3a5ccf12b8ba01e1ab18b6be1d31aac1df30b3198497efd95bfa832302dae::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUK>(arg0, 6, b"DUK", b"sui duk fuks", b"$duk to a buk ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_duk_icon_192x192_df58f35f12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

