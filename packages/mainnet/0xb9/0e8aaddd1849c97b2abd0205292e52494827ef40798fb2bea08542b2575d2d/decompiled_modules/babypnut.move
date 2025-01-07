module 0xb90e8aaddd1849c97b2abd0205292e52494827ef40798fb2bea08542b2575d2d::babypnut {
    struct BABYPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPNUT>(arg0, 6, b"BABYPNUT", b"baby pnut", b"baby peanut the squirrel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ungu_Creative_Toko_Pakaian_Logo_3c47b1e977.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

