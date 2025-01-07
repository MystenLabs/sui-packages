module 0x1f563c747a14ac9c011744e2ffaea071d36ad10a930da3b3d6db7e8168d9bd4d::wacat {
    struct WACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WACAT>(arg0, 6, b"WACAT", b"WAWA CAT SUI", b"Why did the sneaky Wawa cat jump into $WAWA?  Saw the market bounce, hissed at FUD, and clutched those $WAWA bags tight. Now it lounges, smug and unbothered. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_064875f2c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

