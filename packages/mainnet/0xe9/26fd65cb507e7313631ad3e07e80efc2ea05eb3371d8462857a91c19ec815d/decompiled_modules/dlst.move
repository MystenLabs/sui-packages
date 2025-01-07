module 0xe926fd65cb507e7313631ad3e07e80efc2ea05eb3371d8462857a91c19ec815d::dlst {
    struct DLST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLST>(arg0, 6, b"DLST", b"MC DALESTE", b"Aterno daleste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000345451_b228dc2244.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DLST>>(v1);
    }

    // decompiled from Move bytecode v6
}

