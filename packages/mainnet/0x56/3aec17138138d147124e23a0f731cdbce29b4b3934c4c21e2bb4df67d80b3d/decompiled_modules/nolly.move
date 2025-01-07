module 0x563aec17138138d147124e23a0f731cdbce29b4b3934c4c21e2bb4df67d80b3d::nolly {
    struct NOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLLY>(arg0, 6, b"NOLLY", b"Nolly Sui", b"Nolly the most expressive meme coin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017172_bdcf2fa0b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

