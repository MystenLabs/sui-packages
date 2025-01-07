module 0x9e295a8c118f5831116c332a05c3d99ae0fef21805ab2e3b3d49d71f3ca0fd1f::sfog {
    struct SFOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOG>(arg0, 6, b"Sfog", b"SUI FROG", b"just a lil Swog in a big pond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_1732868f69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

