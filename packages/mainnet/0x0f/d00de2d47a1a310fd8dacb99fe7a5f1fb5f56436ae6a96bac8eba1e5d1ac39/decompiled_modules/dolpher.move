module 0xfd00de2d47a1a310fd8dacb99fe7a5f1fb5f56436ae6a96bac8eba1e5d1ac39::dolpher {
    struct DOLPHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHER>(arg0, 6, b"Dolpher", b"Dolph", b"token launched on 9.12.2024 -- national dolphin day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_12_140812_c8c87b755d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

