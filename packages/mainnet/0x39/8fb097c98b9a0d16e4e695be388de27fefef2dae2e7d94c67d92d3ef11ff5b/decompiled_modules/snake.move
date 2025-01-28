module 0x398fb097c98b9a0d16e4e695be388de27fefef2dae2e7d94c67d92d3ef11ff5b::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 9, b"SNAKE", b"The Year Of The Snake", b"https://t.me/YearOfTheSnakeCN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVwSpyWSDrdjYUb2E5cXeACBJAHmLqkuu8YSon2V8zDoc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNAKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

