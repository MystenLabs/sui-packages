module 0xad8fd75f0031df3651078931d3236020c0fa905114b6b986bfd48d4762813a03::cit {
    struct CIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIT>(arg0, 6, b"CIT", b"catintrenches", b"We have been fighting in the trenches for way too long by ourselves. It's time for the cats to help us fight off these jeets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TZ_3yvs_Fj_400x400_e159763f80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

