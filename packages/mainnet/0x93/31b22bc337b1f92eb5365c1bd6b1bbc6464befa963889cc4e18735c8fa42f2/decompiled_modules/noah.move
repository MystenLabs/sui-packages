module 0x9331b22bc337b1f92eb5365c1bd6b1bbc6464befa963889cc4e18735c8fa42f2::noah {
    struct NOAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOAH>(arg0, 6, b"NOAH", b"Noah On SUI", x"4d656574204e6f61682c206865732074686520666c75666669657374207461696c2d77616767696e67206865726f0a6f6e20536f6c616e61207769746820647265616d732061732062696720617320746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EB_l_Rl2_400x400_cf15a0a68e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

