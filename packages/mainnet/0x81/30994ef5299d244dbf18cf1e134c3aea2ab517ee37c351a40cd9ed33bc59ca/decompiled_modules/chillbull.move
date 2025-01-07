module 0x8130994ef5299d244dbf18cf1e134c3aea2ab517ee37c351a40cd9ed33bc59ca::chillbull {
    struct CHILLBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBULL>(arg0, 6, b"CHILLBULL", b"CHILL BULL", b"The Chill Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHILL_BULL_f515b32cbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

