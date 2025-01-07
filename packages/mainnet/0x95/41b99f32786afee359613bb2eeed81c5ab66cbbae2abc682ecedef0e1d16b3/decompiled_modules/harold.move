module 0x9541b99f32786afee359613bb2eeed81c5ab66cbbae2abc682ecedef0e1d16b3::harold {
    struct HAROLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAROLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAROLD>(arg0, 6, b"HAROLD", b"Harold SUI", b"$HAROLD, an adventurous hermit crab, discovered a shimmering shell at the bottom of the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Db_Kjuvf_400x400_ad3aa4800b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAROLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAROLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

