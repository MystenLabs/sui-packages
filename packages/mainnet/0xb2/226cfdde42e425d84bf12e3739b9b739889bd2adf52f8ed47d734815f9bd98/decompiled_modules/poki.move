module 0xb2226cfdde42e425d84bf12e3739b9b739889bd2adf52f8ed47d734815f9bd98::poki {
    struct POKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKI>(arg0, 6, b"POKi", b"POKI", b"Online Oyun Keyfi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000069_2a2cfe73bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

