module 0x9aa2d8baa1638338e82423973157daf559622ee43cc6aa1d37ef0b6b446c1b6a::zen {
    struct ZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEN>(arg0, 6, b"ZEN", b"ZenFrogs", b"ZenFrogs on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963637266.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

