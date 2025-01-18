module 0xc5aa056e6dad4aeb657c1b240eefb25c39c29313d672bd01a9be61085669ff08::killa {
    struct KILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLA>(arg0, 6, b"KILLA", b"Killa Club Inc", b"Hunter's, unite. Welcome to the new club on Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xv2rrf0y_400x400_2f5e88280d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

