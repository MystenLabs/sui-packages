module 0x781f3b5aa52966d4b0c3cabe689279781ceaf2a31635daf944daca063e0c61a7::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 6, b"STONKS", b"SuiStonks", b"$STONKS come to sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suistonk_smaller_text_5b5eac3838.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

