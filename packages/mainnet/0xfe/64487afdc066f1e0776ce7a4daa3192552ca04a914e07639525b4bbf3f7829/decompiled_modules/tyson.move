module 0xfe64487afdc066f1e0776ce7a4daa3192552ca04a914e07639525b4bbf3f7829::tyson {
    struct TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSON>(arg0, 6, b"TYSON", b"MIKETYSUIN", x"5375692077696c6c20626974652074686520656172206f6666206f6620536f6c616e61210a4c6f6e67206c697665204d696b65205479736f6e210a4c6f6e67206c6976652053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034254_8f67aba43c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

