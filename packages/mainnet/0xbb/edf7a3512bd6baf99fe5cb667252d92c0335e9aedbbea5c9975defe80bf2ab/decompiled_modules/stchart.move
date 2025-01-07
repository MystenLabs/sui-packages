module 0xbbedf7a3512bd6baf99fe5cb667252d92c0335e9aedbbea5c9975defe80bf2ab::stchart {
    struct STCHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: STCHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STCHART>(arg0, 6, b"STCHART", b"Suifing the Chart", b"Surf the Chart to greatness!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5800_78e5bdb35c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STCHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STCHART>>(v1);
    }

    // decompiled from Move bytecode v6
}

