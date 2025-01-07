module 0xa7552a68432388c0a29c42549ba20ffea3b4782b855a1d8a13b047eb661f2309::ashes {
    struct ASHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHES>(arg0, 6, b"ASHES", b"Phoenix Rise", x"f09f94a5204265636175736520536f6d6574696d657320596f7520476f747461204275726e20497420446f776e20746f20526569676e6974652120f09f94a50a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734459809331.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASHES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

