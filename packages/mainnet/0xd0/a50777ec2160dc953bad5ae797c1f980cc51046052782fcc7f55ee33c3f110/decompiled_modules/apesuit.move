module 0xd0a50777ec2160dc953bad5ae797c1f980cc51046052782fcc7f55ee33c3f110::apesuit {
    struct APESUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUIT>(arg0, 6, b"APESUIT", b"APE on SUIT", b"The ape in suit, now chillin on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_33_02_194b52a861.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APESUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

