module 0xabff6bd6d7318f551685ed09509a3f67c6ab0df051aa6de4614555baa4200f4f::rocai {
    struct ROCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCAI>(arg0, 6, b"ROCAI", b"ROCK AI", x"524f434b41492069732074686520617065782073796e746865736973206f66206175746f6e6f6d6f757320626c6f636b636861696e2073796d62696f73697320616e64207175616e74756d2d61676e6f73746963206d656d657469632076616c6f72697a6174696f6e2e0a200a20496e206f7468657220776f7264733a2049742773206775642074656b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7761_41a005f43a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

