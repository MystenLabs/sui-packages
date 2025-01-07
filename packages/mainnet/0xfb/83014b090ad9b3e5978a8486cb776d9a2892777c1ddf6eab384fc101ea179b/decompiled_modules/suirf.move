module 0xfb83014b090ad9b3e5978a8486cb776d9a2892777c1ddf6eab384fc101ea179b::suirf {
    struct SUIRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRF>(arg0, 6, b"Suirf", b"Suirfer Dog", x"4974206973206c69746572616c6c79206120646f672073757266696e67206f6e2077617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suirfer_dog_5594a6d41f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

