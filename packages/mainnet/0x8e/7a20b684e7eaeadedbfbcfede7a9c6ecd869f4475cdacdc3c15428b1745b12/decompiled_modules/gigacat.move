module 0x8e7a20b684e7eaeadedbfbcfede7a9c6ecd869f4475cdacdc3c15428b1745b12::gigacat {
    struct GIGACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACAT>(arg0, 6, b"GIGACAT", b"gigacat", b"Behold the Giga Cat, the ultimate fusion of feline elegance and giga-level masculinity! With razor-sharp jawlines, sky-high cheekbones, and piercing eyes, this Chad-like cat dominates both the meme world and your imagination. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733796713663.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGACAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

