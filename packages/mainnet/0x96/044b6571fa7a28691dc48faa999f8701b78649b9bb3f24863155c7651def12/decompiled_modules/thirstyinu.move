module 0x96044b6571fa7a28691dc48faa999f8701b78649b9bb3f24863155c7651def12::thirstyinu {
    struct THIRSTYINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRSTYINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRSTYINU>(arg0, 6, b"THIRSTYINU", b"Thirsty Shiba INU", b"The official pup of Sui, $THIRSTYINU is always on the prowl, parched and craving one thing more Sui! With an insatiable thirst, this Shibas got its eyes locked on every drop. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_85_a1ee118d09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRSTYINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THIRSTYINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

