module 0xc14386a2ff22def684bd142c02d7e52c835077078e5fdfe51d803fd7dcec27f0::sled123 {
    struct SLED123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLED123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLED123>(arg0, 6, b"SLED123", b"SLED", b"suilend in splel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001199_ac78f587ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLED123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLED123>>(v1);
    }

    // decompiled from Move bytecode v6
}

