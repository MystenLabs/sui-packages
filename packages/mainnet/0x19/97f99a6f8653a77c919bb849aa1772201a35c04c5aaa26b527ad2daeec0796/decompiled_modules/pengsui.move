module 0x1997f99a6f8653a77c919bb849aa1772201a35c04c5aaa26b527ad2daeec0796::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSUI>(arg0, 6, b"PENGSUI", b"PENGS", b"PENGSUI IS PENGS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sample71_2_590296233_008f77514b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

