module 0x510939479549d0c645a2f093007a47b63374c304fba5e769e56722c7110f4865::fubj {
    struct FUBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBJ>(arg0, 9, b"Fubj", b"dohe", b"ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7c0b8b2afa6e455083511b153889b65bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUBJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

