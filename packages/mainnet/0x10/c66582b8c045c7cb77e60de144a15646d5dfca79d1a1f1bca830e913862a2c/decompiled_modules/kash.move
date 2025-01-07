module 0x10c66582b8c045c7cb77e60de144a15646d5dfca79d1a1f1bca830e913862a2c::kash {
    struct KASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASH>(arg0, 9, b"KASH", b"Deep clean", x"49e2809964207368757420646f776e207468652046424920486f6f766572206275696c64696e67206f6e20646179206f6e6520616e642072656f70656e20697420746865206e657874206461792061732061206d757365756d206f662074686520646565702073746174652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1d7441d77956edd062451d1fe28dff32blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

