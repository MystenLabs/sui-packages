module 0xa4b2a8f4994c4f79d301444ed95988521549b790e5fa02e942b74b81a13bd1a1::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TES>(arg0, 9, b"TES", b"TESUI", b"Attention, this is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TES>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TES>>(v1);
    }

    // decompiled from Move bytecode v6
}

