module 0x7eb82e264bede5c375fcbc7ca277e991c225e828375f8f298a8292cc50e0b66d::gingy {
    struct GINGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINGY>(arg0, 6, b"GINGY", b"Gingy on sui", b"The Gingerbread Man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_110154_826_c5f541e91b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

