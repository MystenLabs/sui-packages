module 0xd7cef0d016fedc2c70cbfaf1d09e2cdb2803e697af36cddc520dda10a8260ad0::Token_name_2 {
    struct TOKEN_NAME_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_NAME_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_NAME_2>(arg0, 8, b"SYMB2", b"Token name 2", b"Token Description2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN_NAME_2>(&mut v2, 10000 * 0x1::u64::pow(10, 8), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN_NAME_2>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_NAME_2>>(v1);
    }

    // decompiled from Move bytecode v6
}

