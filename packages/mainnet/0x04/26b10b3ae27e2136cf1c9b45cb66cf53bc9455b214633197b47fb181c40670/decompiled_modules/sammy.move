module 0x426b10b3ae27e2136cf1c9b45cb66cf53bc9455b214633197b47fb181c40670::sammy {
    struct SAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMMY>(arg0, 6, b"SAMMY", b"SAMMY THE STAR FISH", b"The sweetest starfish in the sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seastar_65b0a41734.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

