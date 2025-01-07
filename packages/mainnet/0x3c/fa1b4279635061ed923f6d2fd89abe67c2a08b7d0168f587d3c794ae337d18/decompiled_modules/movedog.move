module 0x3cfa1b4279635061ed923f6d2fd89abe67c2a08b7d0168f587d3c794ae337d18::movedog {
    struct MOVEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDOG>(arg0, 6, b"MOVEDOG", b"Movedog", b"Move Dog on SUI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2a89cdd0_5474_47d6_93ab_e38fb21e49b9_734dda4e88.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

