module 0x7fd929cc220fa8c1cc0b1e30af797bba2bed03149da4ca680a5e160be9380eeb::tub {
    struct TUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUB>(arg0, 6, b"TUB", b"Cat In A Tub", b"Cat in a Tub enjoy the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O7z_Jxyrp_Sl6bnw_Pg_Tq_Ogtw_e8e01002db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

