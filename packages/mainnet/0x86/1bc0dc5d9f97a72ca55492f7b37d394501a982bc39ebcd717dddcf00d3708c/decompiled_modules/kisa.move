module 0x861bc0dc5d9f97a72ca55492f7b37d394501a982bc39ebcd717dddcf00d3708c::kisa {
    struct KISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISA>(arg0, 6, b"KISA", b"Kisa", b"KISA is a motherfucking cat, not a pussy like others. A try gangsta now here on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_946cacf7a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

