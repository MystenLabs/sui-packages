module 0xda0c9d3e8007ec544cff11943f8b9d7adf19024ef2ce52ca5bc74503898443da::starship {
    struct STARSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP>(arg0, 6, b"Starship", b"STARSHIP", b"Elon Mask STARSHIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mask_ed342ef11c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

