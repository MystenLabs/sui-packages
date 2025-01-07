module 0x18ac711aca6b18d4c1bc044f03d9e867017e20594f6581e87c1a1fe43df6d457::shpb {
    struct SHPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHPB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHPB>(arg0, 6, b"SHPB", b"Sui Hungry Polar Bear", x"48756e67727920706f6c617262656172206f6e205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_24_da012ec08e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHPB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHPB>>(v1);
    }

    // decompiled from Move bytecode v6
}

