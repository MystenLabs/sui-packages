module 0x5d3226dd57a5f1fdcdcebc0492fce07872930341e9bd56389da565f3772e3306::hfs {
    struct HFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFS>(arg0, 6, b"HFS", b"HopFrogSui", b"First Frog on Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOP_FROG_fda22b484e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

