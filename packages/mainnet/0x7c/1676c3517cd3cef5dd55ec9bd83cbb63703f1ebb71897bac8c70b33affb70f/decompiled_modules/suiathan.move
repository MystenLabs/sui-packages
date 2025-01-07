module 0x7c1676c3517cd3cef5dd55ec9bd83cbb63703f1ebb71897bac8c70b33affb70f::suiathan {
    struct SUIATHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIATHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIATHAN>(arg0, 6, b"SUIATHAN", b"Suiathan", b"Suiathan, a rare and mysterious creature hiding in the ocean of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa11_8d8403e77f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIATHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIATHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

