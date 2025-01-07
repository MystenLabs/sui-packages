module 0x73183d0c90e0ad0cdded76c1818d4fcd7c35bb882f07e609c225e6313d57c5da::lurrypink {
    struct LURRYPINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LURRYPINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LURRYPINK>(arg0, 6, b"LurryPink", b"Lurry Pink", b"Introducing Lurry Pink, the flamboyant financial maven with a flair for feathers and a passion for predicting crypto trends using a crystal ball powered by blockchain magic. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cuqe1xz_G_400x400_1d7695d67d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LURRYPINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LURRYPINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

