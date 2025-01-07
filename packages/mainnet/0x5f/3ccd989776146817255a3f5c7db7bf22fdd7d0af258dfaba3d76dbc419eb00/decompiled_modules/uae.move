module 0x5f3ccd989776146817255a3f5c7db7bf22fdd7d0af258dfaba3d76dbc419eb00::uae {
    struct UAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAE>(arg0, 9, b"uae", b"uae", b"dubai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UAE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

