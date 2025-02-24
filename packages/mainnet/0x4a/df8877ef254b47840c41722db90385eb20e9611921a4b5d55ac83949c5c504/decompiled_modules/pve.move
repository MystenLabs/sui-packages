module 0x4adf8877ef254b47840c41722db90385eb20e9611921a4b5d55ac83949c5c504::pve {
    struct PVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVE>(arg0, 6, b"PVE", b"NO PVP COIN", x"4e6f2062616720776172732c206e6f20626574726179616c732c204e6f205056502c206e6f206472616d612e2e2e204a75737420245056450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008957_42d7f51c7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

