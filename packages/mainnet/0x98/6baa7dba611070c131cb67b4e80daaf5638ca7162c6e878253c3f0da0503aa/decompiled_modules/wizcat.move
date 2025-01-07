module 0x986baa7dba611070c131cb67b4e80daaf5638ca7162c6e878253c3f0da0503aa::wizcat {
    struct WIZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZCAT>(arg0, 6, b"WIZCAT", b"Wizard Cat", b"Chonky cat holding a magic wand has entered the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/459762191_1245768543122783_2241032811834613798_n_3e41f2cbf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

