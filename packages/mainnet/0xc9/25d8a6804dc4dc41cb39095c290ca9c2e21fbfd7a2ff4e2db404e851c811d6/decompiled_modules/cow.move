module 0xc925d8a6804dc4dc41cb39095c290ca9c2e21fbfd7a2ff4e2db404e851c811d6::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 6, b"COW", b"cow coin", b"cow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1782671997121.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

