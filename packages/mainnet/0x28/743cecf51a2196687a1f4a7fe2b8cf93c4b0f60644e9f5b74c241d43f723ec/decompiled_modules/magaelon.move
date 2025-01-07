module 0x28743cecf51a2196687a1f4a7fe2b8cf93c4b0f60644e9f5b74c241d43f723ec::magaelon {
    struct MAGAELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAELON>(arg0, 6, b"MAGAELON", b"MAGA ELON ON SUI", b"Make America Based Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199698_1e84c2d2ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

