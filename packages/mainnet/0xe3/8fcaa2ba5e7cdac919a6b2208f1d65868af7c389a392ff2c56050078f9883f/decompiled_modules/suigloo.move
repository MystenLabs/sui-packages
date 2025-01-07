module 0xe38fcaa2ba5e7cdac919a6b2208f1d65868af7c389a392ff2c56050078f9883f::suigloo {
    struct SUIGLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLOO>(arg0, 6, b"SUIGLOO", b"GLOO", b"Gloo is like a tiny, wobbly sky drop with legs! Big eyes, stubby little feet, and a clumsy charm that makes her irresistibly cute.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/original_bd561f0c74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

