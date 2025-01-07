module 0x51a8297bec81ebbecb17b1706e4db632be18d575a44d72926149dae2cd53b0dd::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 6, b"DOLAN", b"Dolan Duck", b"Look at mi, Dolan iz de cptain now.  Doxxed Community Takeover  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U9w_In7_NX_400x400_934b0d5d79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

