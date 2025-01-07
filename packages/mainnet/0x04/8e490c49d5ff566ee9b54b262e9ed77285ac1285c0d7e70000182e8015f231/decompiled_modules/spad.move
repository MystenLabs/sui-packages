module 0x48e490c49d5ff566ee9b54b262e9ed77285ac1285c0d7e70000182e8015f231::spad {
    struct SPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAD>(arg0, 6, b"SPad", b"SuiPad", b"Sui LaunchPad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_141123_878_586d25155d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

