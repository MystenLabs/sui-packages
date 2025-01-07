module 0x7913bd168c95249bfb2384f146ddd7c0244106b24537183d8a9cc9b326f1ce29::squidmas {
    struct SQUIDMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDMAS>(arg0, 6, b"Squidmas", b"Sui Squidmas", b"Its starting to look a lot like $squidmas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050291_89a25ad502.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

