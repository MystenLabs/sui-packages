module 0xc87d91c7486efe7d69b535e815ee0a353c8ea12d5c5bbb5e3fa136861325b::stoned {
    struct STONED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONED>(arg0, 6, b"Stoned", b"Stoned Stone", b"A stoned stone stoned", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stoned_stone_e48a4db0f0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONED>>(v1);
    }

    // decompiled from Move bytecode v6
}

