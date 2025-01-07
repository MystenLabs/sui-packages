module 0xf684603b4b7088a8ea1750ce43a29bf7b72c2d65968019002d35d434dda65d31::frank {
    struct FRANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANK>(arg0, 6, b"Frank", b"FRANK", b"frank", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsdsdsd_cbe925ae95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

