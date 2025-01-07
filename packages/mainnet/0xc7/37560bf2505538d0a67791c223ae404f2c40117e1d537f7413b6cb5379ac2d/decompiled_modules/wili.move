module 0xc737560bf2505538d0a67791c223ae404f2c40117e1d537f7413b6cb5379ac2d::wili {
    struct WILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILI>(arg0, 6, b"WiLi", b"WildLife", b"Just for the Wildlife.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wildlife_03d72861e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

