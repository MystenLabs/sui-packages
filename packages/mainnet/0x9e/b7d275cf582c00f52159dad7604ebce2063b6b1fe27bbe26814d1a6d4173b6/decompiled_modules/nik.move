module 0x9eb7d275cf582c00f52159dad7604ebce2063b6b1fe27bbe26814d1a6d4173b6::nik {
    struct NIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIK>(arg0, 6, b"NIK", b"nikolas", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

