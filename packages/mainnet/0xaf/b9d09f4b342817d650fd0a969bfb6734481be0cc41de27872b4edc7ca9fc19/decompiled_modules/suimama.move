module 0xafb9d09f4b342817d650fd0a969bfb6734481be0cc41de27872b4edc7ca9fc19::suimama {
    struct SUIMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAMA>(arg0, 9, b"SUIMAMA", b"SUIMAMA", b"Madre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMAMA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

