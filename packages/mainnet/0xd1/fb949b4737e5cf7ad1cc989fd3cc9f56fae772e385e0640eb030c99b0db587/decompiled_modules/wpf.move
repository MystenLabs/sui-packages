module 0xd1fb949b4737e5cf7ad1cc989fd3cc9f56fae772e385e0640eb030c99b0db587::wpf {
    struct WPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPF>(arg0, 6, b"WPF", b"World POG Federation", b"Become part of history with the World POG Federation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761412761459.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

