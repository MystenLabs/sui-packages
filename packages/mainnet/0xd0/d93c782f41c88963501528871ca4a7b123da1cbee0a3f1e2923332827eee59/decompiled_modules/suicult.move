module 0xd0d93c782f41c88963501528871ca4a7b123da1cbee0a3f1e2923332827eee59::suicult {
    struct SUICULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICULT>(arg0, 6, b"SUICULT", b"SUICULT SUI", b"Telling the truth since day one! The CULT is REAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibzluoixlintjpe2ebbu3o7hujkp63yvnx4hh2edqtwyl7jlapt7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

