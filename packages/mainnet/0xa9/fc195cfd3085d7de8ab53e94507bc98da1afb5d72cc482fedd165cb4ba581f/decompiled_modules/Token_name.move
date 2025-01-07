module 0xa9fc195cfd3085d7de8ab53e94507bc98da1afb5d72cc482fedd165cb4ba581f::Token_name {
    struct TOKEN_NAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_NAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_NAME>(arg0, 9, b"SYMB", b"Token name", b"0xFoundation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deepbook.tech/icon.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN_NAME>(&mut v2, 10000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_NAME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_NAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

