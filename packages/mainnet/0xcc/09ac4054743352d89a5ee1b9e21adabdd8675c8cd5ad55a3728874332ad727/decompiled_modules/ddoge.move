module 0xcc09ac4054743352d89a5ee1b9e21adabdd8675c8cd5ad55a3728874332ad727::ddoge {
    struct DDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOGE>(arg0, 9, b"DDOGE", b"Drunk Doge ", b"Drunk Doge Always Drinking alcohol ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e85b329fc5e370f1c05f60905475f442blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

