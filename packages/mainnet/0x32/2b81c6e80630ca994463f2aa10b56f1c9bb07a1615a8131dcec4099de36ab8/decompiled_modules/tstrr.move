module 0x322b81c6e80630ca994463f2aa10b56f1c9bb07a1615a8131dcec4099de36ab8::tstrr {
    struct TSTRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTRR>(arg0, 7, b"TSTRR", b"tstr", b"TSTR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.kraken.com/marketing/web/icons-uni-webp/s_inj.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSTRR>(&mut v2, 7897890000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTRR>>(v2, @0xa4dee7e7d6686865508d157f233d3203232efb9744843743704564b718f0dcf4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSTRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

