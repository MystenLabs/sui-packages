module 0x1fcf94bc31a5bc900a5ff8d77f81c1018d2fd77212b0c43a68e2971cf2be538d::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"Boi", b"BoiOnSui", b"Tired waiting hop, I think Turbo better than hopfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956694203.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

