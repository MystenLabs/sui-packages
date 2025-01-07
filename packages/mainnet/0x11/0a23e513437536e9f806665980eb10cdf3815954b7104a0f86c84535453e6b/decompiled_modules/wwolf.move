module 0x110a23e513437536e9f806665980eb10cdf3815954b7104a0f86c84535453e6b::wwolf {
    struct WWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWOLF>(arg0, 6, b"WWOLF", b"FLOWW", b"Who faded??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010112_f53daeb32f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

