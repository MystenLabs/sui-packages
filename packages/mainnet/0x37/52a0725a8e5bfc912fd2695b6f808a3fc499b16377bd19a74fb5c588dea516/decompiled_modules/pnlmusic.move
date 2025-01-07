module 0x3752a0725a8e5bfc912fd2695b6f808a3fc499b16377bd19a74fb5c588dea516::pnlmusic {
    struct PNLMUSIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNLMUSIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNLMUSIC>(arg0, 9, b"PNLMUSIC", b"PNL", b"Official token of PNL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PNLMUSIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNLMUSIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNLMUSIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

