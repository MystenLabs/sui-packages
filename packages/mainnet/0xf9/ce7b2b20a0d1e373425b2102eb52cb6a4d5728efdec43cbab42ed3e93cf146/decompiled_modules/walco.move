module 0xf9ce7b2b20a0d1e373425b2102eb52cb6a4d5728efdec43cbab42ed3e93cf146::walco {
    struct WALCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALCO>(arg0, 9, b"WALCO", b"walicoin", b"new memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f62690be22fd08878bacd20c8f50dd17blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

