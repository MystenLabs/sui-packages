module 0x415863dbe21e27208475138e4012b38808dc8c72709559e92aa269bb3825bf39::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXI>(arg0, 6, b"TAXI", b"SUI TAXI", x"68747470733a2f2f742e6d652f6d656d65746178695f7375690a6d656d65746178692e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TMN_4_Cmzw_400x400_fbe52fcbd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

