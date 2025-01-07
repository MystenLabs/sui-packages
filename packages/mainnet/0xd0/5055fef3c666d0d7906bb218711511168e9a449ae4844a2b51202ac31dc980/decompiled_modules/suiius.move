module 0xd05055fef3c666d0d7906bb218711511168e9a449ae4844a2b51202ac31dc980::suiius {
    struct SUIIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIUS>(arg0, 9, b"SUIIUS", b"SUIIUS", b"mirror", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIIUS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

