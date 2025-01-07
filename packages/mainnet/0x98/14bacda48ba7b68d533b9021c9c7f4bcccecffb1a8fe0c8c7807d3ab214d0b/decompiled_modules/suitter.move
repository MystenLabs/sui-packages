module 0x9814bacda48ba7b68d533b9021c9c7f4bcccecffb1a8fe0c8c7807d3ab214d0b::suitter {
    struct SUITTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTER>(arg0, 6, b"SUITTER", b"SUITER", x"546865206d6173636f74206f662053756920636861696e2e0a247375697474657220686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_015626626_37490371f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

