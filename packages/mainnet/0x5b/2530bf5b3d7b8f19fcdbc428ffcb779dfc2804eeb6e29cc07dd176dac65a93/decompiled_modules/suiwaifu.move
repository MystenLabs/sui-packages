module 0x5b2530bf5b3d7b8f19fcdbc428ffcb779dfc2804eeb6e29cc07dd176dac65a93::suiwaifu {
    struct SUIWAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAIFU>(arg0, 6, b"SUIWAIFU", b"Sui Waifu", b"Waifu with water. Sui Waifu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030563_659f7c8f3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWAIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWAIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

