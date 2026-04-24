module 0xbc7bc444a8f725f2aaf049706f1257813c11050d0c45f16bb0211a62bc544687::will_trump_acquire_greenland_before_2027_yes {
    struct WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027_YES>(arg0, 0, b"WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027_YES", b"WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027 YES", b"WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_TRUMP_ACQUIRE_GREENLAND_BEFORE_2027_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

