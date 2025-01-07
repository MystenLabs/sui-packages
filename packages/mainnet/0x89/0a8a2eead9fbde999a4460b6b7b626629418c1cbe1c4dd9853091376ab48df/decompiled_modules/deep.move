module 0x890a8a2eead9fbde999a4460b6b7b626629418c1cbe1c4dd9853091376ab48df::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DEEP v2 (complete bridge: deepv2.com)", b"complete migration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/33391.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP>(&mut v2, 10000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

