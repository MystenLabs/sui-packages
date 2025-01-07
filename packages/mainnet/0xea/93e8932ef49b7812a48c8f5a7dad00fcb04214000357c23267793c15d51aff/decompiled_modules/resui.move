module 0xea93e8932ef49b7812a48c8f5a7dad00fcb04214000357c23267793c15d51aff::resui {
    struct RESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESUI>(arg0, 6, b"RESUI", b"RESISTANCE SUI", b"SUI TO THE MOON (RESISTANCE SUI), No Utility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000211748_c08d48592a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

