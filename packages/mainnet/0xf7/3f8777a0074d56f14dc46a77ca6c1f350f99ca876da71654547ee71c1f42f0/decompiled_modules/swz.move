module 0xf73f8777a0074d56f14dc46a77ca6c1f350f99ca876da71654547ee71c1f42f0::swz {
    struct SWZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWZ>(arg0, 6, b"SWZ", b"SuperWeedz", b"Weed that flys you pass Uranus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_423178362490710_1da92841d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

