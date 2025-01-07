module 0xf2913cf75cd9d08236037f4d621ae2486c397bcb400e7558697567c198f9204e::idlcc {
    struct IDLCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDLCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDLCC>(arg0, 6, b"IDLCC", b"I dont like cat coin", b"coin for those people who are tired of so many cat themed coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732031010150.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDLCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDLCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

