module 0x877b4521e43b88e8c69f292459250ef974b99f0e713ef934dd896c9f3d1918e::kisa {
    struct KISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISA>(arg0, 6, b"KISA", b"kisa on Sui", b"KISA is a motherfucking cat, not a pussy like others. A try gangsta now here on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Afpn_AGNM_400x400_22df032e61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

