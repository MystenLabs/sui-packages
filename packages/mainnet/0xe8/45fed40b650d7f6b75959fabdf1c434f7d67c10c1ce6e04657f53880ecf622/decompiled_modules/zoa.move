module 0xe845fed40b650d7f6b75959fabdf1c434f7d67c10c1ce6e04657f53880ecf622::zoa {
    struct ZOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOA>(arg0, 6, b"ZOA", b"Myzoa", b"Original instant online chat, give you a different trading experience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241028_083025_com_microsoft_emmx_edit_155072787539436_3b9333977d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

