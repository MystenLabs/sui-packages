module 0xa75a87aeaa8d0a30fc41a1a5a0a03c65e816cf904434ea9484242c2d5c944aaf::my_module {
    struct MY_MODULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_MODULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_MODULE>(arg0, 6, b"HESOLD", b"Christmas Pumper", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TOKEN_IMAGE_URL")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MY_MODULE>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_MODULE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_MODULE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

