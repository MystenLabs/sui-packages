module 0x7d104fde8eb2d4af831be91b0230bc8bee6f2d23f32d8f7aa8fe6b488ab11ced::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 6, b"AF", b"AstroFox ", b"Astro AF ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732424028635.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

