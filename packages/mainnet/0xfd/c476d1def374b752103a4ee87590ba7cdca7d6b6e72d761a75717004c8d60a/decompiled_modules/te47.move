module 0xfdc476d1def374b752103a4ee87590ba7cdca7d6b6e72d761a75717004c8d60a::te47 {
    struct TE47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TE47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TE47>(arg0, 6, b"TE47", b"TrumpElon47", x"546f6e696768742077652063656c656272617465210a4d616b6520416d657269636120262053756920477265617420416761696e2121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005789510.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TE47>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE47>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

