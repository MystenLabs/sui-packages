module 0xc61f4db0055a2f2036dcc653810c6ab862b36934d124b911bec4c3617194182::cfrog {
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

