module 0x42492719ba719776e39c4fe9bca2a4e97ff0d51554dd7468df124bfee514914e::minidog {
    struct MINIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDOG>(arg0, 6, b"MINIDOG", b"MINIDOG ON SUI", b"Tools for the community!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_GZY_8a_UM_400x400_509a0031c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

