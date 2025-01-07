module 0x34ac4a782d67e5170fef71eeb3699b3377e687f4fda86db9529ce23cfd76bd9c::molly {
    struct MOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLLY>(arg0, 1, b"MOLLY", b"MOLLY", b"MOL7LY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOLLY>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

