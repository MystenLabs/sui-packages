module 0xfff666e1f90e16ba066a9ca0caaf13b82bac31f4558ba7eb5c981536f961c218::kuromi {
    struct KUROMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUROMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUROMI>(arg0, 6, b"KUROMI", b"KUROMI SUI", b"KUROMI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_8a61d413da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUROMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUROMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

