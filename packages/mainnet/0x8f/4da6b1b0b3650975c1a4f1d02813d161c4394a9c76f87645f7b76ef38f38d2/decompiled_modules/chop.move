module 0x8f4da6b1b0b3650975c1a4f1d02813d161c4394a9c76f87645f7b76ef38f38d2::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"First Chop On Sui", b"First Chop On Sui: https://chopcoinonsui.mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_42_fc75d87a9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

