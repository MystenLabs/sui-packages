module 0xc9ed6ca7c76d31178f7d803e1e846b1ff0215ba0727847c54a9cd9d9f2fd9b19::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"WAIFU", b"SUI WAIFU", b"First Waifu on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9560_500231476f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

