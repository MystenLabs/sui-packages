module 0x982ef7121641c33efa2b70bf6f6400f100316c6f14e527cf6580af37a035acd6::testr {
    struct TESTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTR>(arg0, 6, b"TESTR", b"test123", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dmis642ko8zb1_ffbea58baa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

