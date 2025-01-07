module 0x428aaf70ab56c1f70209d2720ec20b093b76947e11d18d2fcb2f20a156b60d8a::wangsui {
    struct WANGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANGSUI>(arg0, 6, b"WANGSUI", b"Wang on sui", x"4920414d2057414e47202e0a0a583a2068747470733a2f2f782e636f6d2f77616e676f6e7375690a54656c656772616d3a2068747470733a2f2f742e6d652f77616e676f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul64_20250103023643_0ee8610535.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

