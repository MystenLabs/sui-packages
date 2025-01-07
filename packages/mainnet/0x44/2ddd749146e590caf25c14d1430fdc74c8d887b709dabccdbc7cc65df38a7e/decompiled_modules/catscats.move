module 0x442ddd749146e590caf25c14d1430fdc74c8d887b709dabccdbc7cc65df38a7e::catscats {
    struct CATSCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSCATS>(arg0, 6, b"CATSCATS", b"Everyone loves CATs", b"So cute CATs\\n.CATs are very cute\\n.Live with them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JCMEME6ZQMG6X4ZJ17Z1XZJH/01JEQB1FJSYS6EPZ99NPY68J82")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATSCATS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

