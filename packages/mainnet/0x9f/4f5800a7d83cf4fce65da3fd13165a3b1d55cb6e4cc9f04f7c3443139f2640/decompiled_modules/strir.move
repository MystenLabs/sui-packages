module 0x9f4f5800a7d83cf4fce65da3fd13165a3b1d55cb6e4cc9f04f7c3443139f2640::strir {
    struct STRIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRIR>(arg0, 6, b"STRIR", b"Stir the starfish", b"The most sexy choice in the sui sea. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014594_bdaf396225.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

