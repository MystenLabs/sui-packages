module 0xdcf4317d5e6e307b4ed2f398e23805ce731e21a5736d39dfe234df693dd3c62b::emzi {
    struct EMZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMZI>(arg0, 9, b"Emzi", b"Emmzii", b"Just fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/731d2a83562c39fc4f3cc14a364a647dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMZI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMZI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

