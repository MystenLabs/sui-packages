module 0xc89e03273fc97e1d6227a28442f67506eb0df7df4fd9d68bbd479989e4e6cecb::haedal {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDAL>(arg0, 9, b"HAEDAL", b"HAEDAL Token", b"Governance token for veHEADAL platform", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

