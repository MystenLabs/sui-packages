module 0xacf4fa66587018053872662eb9cad9bd582fabd0751322dcf455d8c820173aa1::aaal {
    struct AAAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAL>(arg0, 6, b"AAAL", b"aaa Lion", b"The Lion says - AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaalion_1e51413e7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

