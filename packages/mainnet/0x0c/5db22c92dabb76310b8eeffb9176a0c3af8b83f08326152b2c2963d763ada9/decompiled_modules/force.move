module 0xc5db22c92dabb76310b8eeffb9176a0c3af8b83f08326152b2c2963d763ada9::force {
    struct FORCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORCE>(arg0, 6, b"Force", b"Laxo On Sui", b"NIQUEZTOUSVOSMERES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/438078007_10228027948458262_643429033324803823_n_7e76d62c7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

