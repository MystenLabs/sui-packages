module 0x4e43b217ed1a1e3d84c3dcde3ae422d35f2f0ba59ecd523d1cf77c60d1978841::trumpjoker {
    struct TRUMPJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPJOKER>(arg0, 6, b"TRUMPJOKER", b"trump  joker", b"Surf the SUI wave with TRUMP JOKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729355651993_dee6b222f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

