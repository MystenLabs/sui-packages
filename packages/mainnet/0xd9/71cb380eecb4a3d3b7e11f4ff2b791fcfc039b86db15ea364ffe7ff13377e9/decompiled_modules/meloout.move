module 0xd971cb380eecb4a3d3b7e11f4ff2b791fcfc039b86db15ea364ffe7ff13377e9::meloout {
    struct MELOOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELOOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELOOUT>(arg0, 6, b"Meloout", b"Melo out on sui", b"All we need is some weed and a place to chill ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gup_A6iky_400x400_2de23890a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELOOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELOOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

