module 0x8edcaa5992e3a3847c0a2afc3b0429a024d44fe9b4c6c828ba8d543a5e50e18f::mmeo {
    struct MMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEO>(arg0, 9, b"MMEO", b"juninho", b"new ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3b24232d08569e0b2e786b2682e3cc7eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

