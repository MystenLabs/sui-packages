module 0x387c9ac972a80e65fe2bf343fce7efa8e9cec1369b75cf76aeb754a42f19183c::smashy {
    struct SMASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASHY>(arg0, 6, b"SMASHY", b"Smash Guy", b"This coin is dedicated to the famous Smash Guy aka The hatched wielding hitchhiker (watch it on Netflix). This coin is for all those who believe in the good in people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kai_the_Hatchet_Wielding_Hitchhiker_f334274b6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

