module 0x1c64b785cbb34d2057639b1ca4b70aaa9b05d2a79434de2aa74fd6100dd03b29::no {
    struct NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO>(arg0, 6, b"NO", b"$NO", x"4e6f2054656c656772616d0a4e6f20547769747465720a4e6f20776562736974650a0a45766572797468696e672077696c6c2062652067656e657261746564206279207061727469636970616e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Since_the_original_prompt_is_NO_I_will_make_a_0_30bfaafb9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NO>>(v1);
    }

    // decompiled from Move bytecode v6
}

