module 0x99047a978490873c8964174cfa7c1dc92709e0400f0abb148107ec730572b359::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPP>(arg0, 6, b"PPP", b"PPP On Sui", b"First PPP On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_3_2_f38eac3358.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

