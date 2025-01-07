module 0xc38920eacdad45ced40ab177a89e2dabbced5a0fb7a7f4e5db83180f3a57bce::mcd {
    struct MCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCD>(arg0, 6, b"MCD", b"MCDonald Trump", b"ust launched. Following news that Trump works at McDonalds. 6k area.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_579975745b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

