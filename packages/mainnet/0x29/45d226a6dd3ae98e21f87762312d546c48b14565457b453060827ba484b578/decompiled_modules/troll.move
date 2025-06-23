module 0x2945d226a6dd3ae98e21f87762312d546c48b14565457b453060827ba484b578::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 6, b"TROLL", b"Troll Sui", b"Get Trolled on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicy3mcuygso3dla6yroc7zh4vnmsjbvw5dbv3uzz4tx6vabzogjpi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TROLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

