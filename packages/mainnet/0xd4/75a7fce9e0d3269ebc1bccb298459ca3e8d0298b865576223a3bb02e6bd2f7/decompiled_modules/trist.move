module 0xd475a7fce9e0d3269ebc1bccb298459ca3e8d0298b865576223a3bb02e6bd2f7::trist {
    struct TRIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIST>(arg0, 9, b"TRIST", b"Trist", b"Just a trist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRIST>(&mut v2, 222222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

