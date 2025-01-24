module 0xfece374f284d4e3b6dbcbc97f74b4f270c3f1bcc6c422861aff7396db0d5dcb3::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"GOATCoin", b"The GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"file:///var/folders/b3/jx5j4zsj2hd1c_x10rk5cggh0000gn/T/TemporaryItems/NSIRD_screencaptureui_maLsLj/Sk%C3%A6rmbillede%202025-01-24%20kl.%2008.45.11.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v2, @0xa6695d15ed427b56096284228532a0319e6f562f95cda4c18119b2444bffa01a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

