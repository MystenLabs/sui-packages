module 0x7ae50ab36618e7e9c3c0d4934e0d3f26cfb451da5a7111e591a675d9dcb85c04::kisssui {
    struct KISSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISSSUI>(arg0, 6, b"KISSSUI", b"KISSUI", b"KISSUI is the meme token spreading love and fun across the blockchain. 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ky3_V4_U_Bn_400x400_3a8d2905cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

