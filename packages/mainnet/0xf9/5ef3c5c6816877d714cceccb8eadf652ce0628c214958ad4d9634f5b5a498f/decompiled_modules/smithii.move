module 0xf95ef3c5c6816877d714cceccb8eadf652ce0628c214958ad4d9634f5b5a498f::smithii {
    struct SMITHII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMITHII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMITHII>(arg0, 6, b"SMITHII", b"Smithii", b"Join Smithii wild meme full of challenges on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056824_8307b2db86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMITHII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMITHII>>(v1);
    }

    // decompiled from Move bytecode v6
}

