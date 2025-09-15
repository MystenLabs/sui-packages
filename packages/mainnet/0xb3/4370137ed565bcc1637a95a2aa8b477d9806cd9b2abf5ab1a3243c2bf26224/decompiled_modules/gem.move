module 0xb34370137ed565bcc1637a95a2aa8b477d9806cd9b2abf5ab1a3243c2bf26224::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 6, b"GEM", b"GRAND EGYPTIAN", b"The Grand Egyptian Museum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757951201340.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

