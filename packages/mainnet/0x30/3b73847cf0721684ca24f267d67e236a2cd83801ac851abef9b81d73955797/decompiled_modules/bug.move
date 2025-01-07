module 0x303b73847cf0721684ca24f267d67e236a2cd83801ac851abef9b81d73955797::bug {
    struct BUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUG>(arg0, 6, b"BUG", b"GLONK", b"I\"m", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Glonk_2a6c076f3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

