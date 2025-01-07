module 0x9534d3d09db5581084ee1d24163613de5e88ebf6639db74a52731339148835a5::tood2 {
    struct TOOD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOD2>(arg0, 6, b"TOOD2", b"fas", b"sda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20221106_194015_2x_59d7ad2900.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOD2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOD2>>(v1);
    }

    // decompiled from Move bytecode v6
}

