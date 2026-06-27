module 0x26a8b5cc8185bb7a79ef45f0a09c408baa834ddd79aaeea8b30069dfb0948384::zec {
    struct ZEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEC>(arg0, 6, b"ZEC", b"Zcash", b"Zcash sulla rete SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1782581008382.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

