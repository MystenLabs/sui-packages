module 0x202dc222a88f888ddc5da5bb4faf0671ee76286e5fd57de2fd1256ee9cb5e9ce::v {
    struct V has drop {
        dummy_field: bool,
    }

    fun init(arg0: V, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<V>(arg0, 9, b"V", b"VENDETTA", b"A fully on-chain, multiplayer strategy game on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a4d7f0e1e91b71d9adcf6c0a342c84adblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<V>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<V>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

