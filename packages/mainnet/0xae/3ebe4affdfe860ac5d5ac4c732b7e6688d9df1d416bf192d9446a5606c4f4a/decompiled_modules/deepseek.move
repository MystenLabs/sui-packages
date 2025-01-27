module 0xae3ebe4affdfe860ac5d5ac4c732b7e6688d9df1d416bf192d9446a5606c4f4a::deepseek {
    struct DEEPSEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPSEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPSEEK>(arg0, 9, b"DeepSeek", b"DeepSeek AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVaPE46WWMjpbKrVGW6EYAdrhTrZ9zRhKhDgZKGvbJpBD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEPSEEK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEPSEEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPSEEK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

