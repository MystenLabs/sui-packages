module 0x8ae2e32bbefa7d172960fa481bd6a6364274680d8cab4cc0fefe91378925c0cd::flight5 {
    struct FLIGHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIGHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIGHT5>(arg0, 6, b"Flight5", b"starship", b"starship flight5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3674_5cc63a9779.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIGHT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIGHT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

