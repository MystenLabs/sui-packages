module 0x1dd1851c02651ea09efabc98d9fe3bc403396c16f9a1f055a5063f35f6d6f45b::fdown {
    struct FDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOWN>(arg0, 9, b"FDOWN", b"Finally Down", b"when market went sideways and finally goes down.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5b7e5047bd652fa5ee4d26a43c186e15blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

