module 0x215fb22e9fc23c3746bfff2918c3dd62d057b73126aaccd51cca218f18defe7b::suisol {
    struct SUISOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISOL>(arg0, 9, b"SUISOL", b"SUISOL", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

