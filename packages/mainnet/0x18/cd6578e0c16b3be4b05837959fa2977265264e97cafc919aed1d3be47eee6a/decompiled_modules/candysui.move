module 0x18cd6578e0c16b3be4b05837959fa2977265264e97cafc919aed1d3be47eee6a::candysui {
    struct CANDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDYSUI>(arg0, 6, b"CANDYSUI", b"CANDY SUI", b"Get Some Candy Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_12_03_00_02_56_2d2191431d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

