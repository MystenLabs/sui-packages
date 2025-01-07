module 0xb95a97aa5635f241f2dca991e8c17cb9472a2c045c8f574be0c665baea33fa77::ofm {
    struct OFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFM>(arg0, 6, b"OFM", b"Onlyfans Meta", b"Official token of Only Fans metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5746_ae19987f82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

