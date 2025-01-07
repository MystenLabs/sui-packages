module 0xf25a6e5e8643939567ab3a50cc82d3a8ae0180cc9d5a2accf3966792f6228ad1::minidoge {
    struct MINIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDOGE>(arg0, 6, b"MINIDOGE", b"Mini Doge", b"MINIDOGE is Babydoge Brother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/200_f35f160305.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

