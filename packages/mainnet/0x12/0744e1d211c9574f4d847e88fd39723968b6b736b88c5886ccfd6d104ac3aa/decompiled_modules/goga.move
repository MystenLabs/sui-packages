module 0x120744e1d211c9574f4d847e88fd39723968b6b736b88c5886ccfd6d104ac3aa::goga {
    struct GOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGA>(arg0, 6, b"GOGA", b"GOVERNA", b"This structured plan is designed to ensure a smooth launch, boost visibility, and cultivate a vibrant and engaged community from the very beginning.Game is amazing were bring to you. Joing for more info", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6266_9a3f76747e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

