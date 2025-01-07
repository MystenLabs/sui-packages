module 0x71be9b07d578b28b7bf63e77310400b0c0cf80132cd46abbbbced3772c9cc3c2::manti {
    struct MANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTI>(arg0, 9, b"MANTI", b"MANTI", b"Manti I coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-Qtk-b-WD64Yf72-XxfE5r7anPyd0c6YIZw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANTI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

