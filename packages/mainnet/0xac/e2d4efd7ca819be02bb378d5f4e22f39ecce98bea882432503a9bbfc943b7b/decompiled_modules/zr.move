module 0xace2d4efd7ca819be02bb378d5f4e22f39ecce98bea882432503a9bbfc943b7b::zr {
    struct ZR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZR>(arg0, 6, b"ZR", b"Zoro", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757071147327.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

