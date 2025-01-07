module 0x16e3abe5516ca84df5aee6cb48cd903fc4cee4d4b993586b9b7252a363bcc94b::stsu {
    struct STSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSU>(arg0, 6, b"Stsu", b"SantaSui", b"SantaSui Riding the Fastest Sleigh on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4812_dca6479e76.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

