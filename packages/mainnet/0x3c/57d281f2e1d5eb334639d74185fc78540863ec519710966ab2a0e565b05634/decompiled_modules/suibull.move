module 0x3c57d281f2e1d5eb334639d74185fc78540863ec519710966ab2a0e565b05634::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 6, b"Suibull", b"terminator", b"The Terminator bull is the symbol of the season. Why not 500-600 million Mcap Sui memes in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731360063138.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

