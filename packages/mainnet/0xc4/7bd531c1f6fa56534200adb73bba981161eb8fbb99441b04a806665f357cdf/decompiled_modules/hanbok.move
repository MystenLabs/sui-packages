module 0xc47bd531c1f6fa56534200adb73bba981161eb8fbb99441b04a806665f357cdf::hanbok {
    struct HANBOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBOK>(arg0, 6, b"Hanbok", b"HANBOK", x"48616e626f6b2069732061204b6f7265616e20747261646974696f6e0a4974206973206e6f742066726f6d204368696e612e0a0a4e6f2054656c656772616d0a4e6f20547769747465720a4e6f20776562736974650a0a45766572797468696e672077696c6c2062652067656e657261746564206279207061727469636970616e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_beautiful_woman_with_delicate_facial_featur_3_7d8b3832f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

