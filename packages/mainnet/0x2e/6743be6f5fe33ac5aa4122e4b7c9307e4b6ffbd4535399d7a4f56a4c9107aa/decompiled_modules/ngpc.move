module 0x2e6743be6f5fe33ac5aa4122e4b7c9307e4b6ffbd4535399d7a4f56a4c9107aa::ngpc {
    struct NGPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGPC>(arg0, 9, b"NGPC", b"Nougapouic", b"Pouic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8c6d95c70c40779603978eb82eb0ff47blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGPC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGPC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

