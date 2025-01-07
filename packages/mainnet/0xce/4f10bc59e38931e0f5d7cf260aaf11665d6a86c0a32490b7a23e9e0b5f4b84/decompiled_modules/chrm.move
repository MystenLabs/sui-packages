module 0xce4f10bc59e38931e0f5d7cf260aaf11665d6a86c0a32490b7a23e9e0b5f4b84::chrm {
    struct CHRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRM>(arg0, 6, b"CHRM", b"CHARMSUI", b"Launch CharmSui with burned liquidity, initial NFTs, and vibrant community-building efforts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197123_32db9c554c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

