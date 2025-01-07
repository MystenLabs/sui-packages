module 0xfa2b145d18d0b385645837b2f5a0948bb226389c98ea23d0685cc6e6ec0a14e6::seapup {
    struct SEAPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAPUP>(arg0, 6, b"SEAPUP", b"SEA PUP", b"The little seal who became the favorite of the whole sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SEAPUP_Logo_cae5f3a460.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

