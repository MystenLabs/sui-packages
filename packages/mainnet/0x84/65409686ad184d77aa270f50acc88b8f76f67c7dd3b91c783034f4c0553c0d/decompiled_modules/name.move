module 0x8465409686ad184d77aa270f50acc88b8f76f67c7dd3b91c783034f4c0553c0d::name {
    struct NAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAME>(arg0, 6, b"NAME", b"yourcoin", b"lorem ipsum dolor sit amet, consecterur adipiscing elit, sed do.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957810085.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

