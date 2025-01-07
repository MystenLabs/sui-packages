module 0xaec54637067919d4aca651e999aed09f39fa629c3a4547c0ab2f7393b2d951eb::hopwen {
    struct HOPWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPWEN>(arg0, 6, b"HOPWEN", b"HOPWEN?", b"Just having a bit of a laugh. HOPWEN?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020412_608461f3c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

