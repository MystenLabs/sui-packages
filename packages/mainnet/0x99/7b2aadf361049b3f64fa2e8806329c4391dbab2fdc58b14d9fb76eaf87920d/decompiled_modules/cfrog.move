module 0x997b2aadf361049b3f64fa2e8806329c4391dbab2fdc58b14d9fb76eaf87920d::cfrog {
    struct CFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFROG>(arg0, 6, b"CFROG", b"CRAZY FROG", b"Lets go to moon :) No Sell - Never Sell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CF_1_42aab040d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

