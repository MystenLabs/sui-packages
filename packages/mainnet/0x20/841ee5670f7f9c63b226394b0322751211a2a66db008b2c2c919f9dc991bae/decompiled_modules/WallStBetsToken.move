module 0x20841ee5670f7f9c63b226394b0322751211a2a66db008b2c2c919f9dc991bae::WallStBetsToken {
    struct WALLSTBETSTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLSTBETSTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLSTBETSTOKEN>(arg0, 6, b"WallStBetsToken", b"WSB", b"YOLO Gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmUPHvZGXyNWgB7U1qkaS2CGDr76dfpr4gsXeMU5GNJP71")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLSTBETSTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLSTBETSTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

