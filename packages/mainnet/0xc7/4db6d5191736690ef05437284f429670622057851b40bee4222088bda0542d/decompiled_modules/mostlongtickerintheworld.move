module 0xc74db6d5191736690ef05437284f429670622057851b40bee4222088bda0542d::mostlongtickerintheworld {
    struct MOSTLONGTICKERINTHEWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSTLONGTICKERINTHEWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSTLONGTICKERINTHEWORLD>(arg0, 9, b"MOSTLONGTICKERINTHEWORLD", b"THE MOST LONG TICKER IN THE WORLD", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOSTLONGTICKERINTHEWORLD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSTLONGTICKERINTHEWORLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSTLONGTICKERINTHEWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

