module 0x78ba04506680049213024e58468cba843eac7decbff57bec6192a43c909935a::merman {
    struct MERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERMAN>(arg0, 6, b"MERMAN", b"TRUMP SUI", b" Its ya boy Trump, its time to put the border underwater, splashin now on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_21_41_46_2674333d01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

