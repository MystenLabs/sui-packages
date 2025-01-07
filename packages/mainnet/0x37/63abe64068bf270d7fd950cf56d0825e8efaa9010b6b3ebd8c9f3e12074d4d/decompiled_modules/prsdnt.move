module 0x3763abe64068bf270d7fd950cf56d0825e8efaa9010b6b3ebd8c9f3e12074d4d::prsdnt {
    struct PRSDNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRSDNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRSDNT>(arg0, 6, b"PRSDNT", b"MR PRESIDENT", b"$PRSDNT is coming to be the best meme token of USA Elections!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_ac358f7a05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRSDNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRSDNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

