module 0x1c2a561f973264e701704355690e587e5cd7ae1bad4197d0257b8e8a6a319378::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 6, b"CCAT", b"Chill Cats", b"The chill cats of sui is bringing awesome vibes to the water chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731736397821.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

