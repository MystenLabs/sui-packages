module 0x3c200b3cf4e42cb2cc5445fc35594206fb9e60d4c998e4f42643be47667af975::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"NAMI of The Seven Seas", x"546865205355494e414d492069732068657265210a5355492773204e414d492069732068657265210a0a5669626573206f66207468652053554920736561", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_6_72d9871f42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

