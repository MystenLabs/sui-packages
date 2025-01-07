module 0x6a7c64c0e236df422466716da2231591ef282911fb7c3836b5615d61aef8a7f2::sragon {
    struct SRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRAGON>(arg0, 6, b"SRAGON", b"$DRAGON ON SUI", b" The battle between diamond hands and market manipulation is as old as crypto itself. But like in every legend, the brave always stand their ground.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241011201421_06a29b11e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

