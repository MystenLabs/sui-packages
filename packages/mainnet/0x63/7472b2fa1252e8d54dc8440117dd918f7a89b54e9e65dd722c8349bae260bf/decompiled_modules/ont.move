module 0x637472b2fa1252e8d54dc8440117dd918f7a89b54e9e65dd722c8349bae260bf::ont {
    struct ONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONT>(arg0, 6, b"ONT", b"ONT token", b"ONT on Akasui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/36d82140-23f7-44ec-b3a9-19ce023492de.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

