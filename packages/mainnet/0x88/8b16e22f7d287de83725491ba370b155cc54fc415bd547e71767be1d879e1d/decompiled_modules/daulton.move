module 0x888b16e22f7d287de83725491ba370b155cc54fc415bd547e71767be1d879e1d::daulton {
    struct DAULTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAULTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAULTON>(arg0, 9, b"DAULTON", b"Daulton Dog", x"244441554c544f4e20697320746865206e65787420626967204d656d65636f696e20f09fa7a82031303030205820706f74656e7469616c20f09f8e89", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1822983347133460480/ydoya7fG_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAULTON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAULTON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAULTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

