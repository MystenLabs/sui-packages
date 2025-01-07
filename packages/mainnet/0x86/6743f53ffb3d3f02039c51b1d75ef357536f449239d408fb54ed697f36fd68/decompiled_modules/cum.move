module 0x866743f53ffb3d3f02039c51b1d75ef357536f449239d408fb54ed697f36fd68::cum {
    struct CUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUM>(arg0, 6, b"CUM", b"CumLord", b"The Cummiest cum flavoured dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_7be8d4ad15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

