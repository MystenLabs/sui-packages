module 0xe0e4c7232ebe8b0f7b6213d591f785c2579706a4f15e38b1562779381bba75cf::awclul {
    struct AWCLUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWCLUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWCLUL>(arg0, 6, b"AWClul", b"Whaazzinu", b"one two three viva lalgerie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_547f705635.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWCLUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWCLUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

