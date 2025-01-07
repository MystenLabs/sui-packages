module 0xa85fe84e6af9cc185ac01e6039504a946e3bed748a28c205f210bfd4da8a517b::much {
    struct MUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUCH>(arg0, 6, b"MUCH", b"Zelon Husk", x"4d75636820496e6e6f766174696f6e20210a4d75636820496e7465726e74696f6e2043757465650a4d75636820546f20546865204d6f6f6e200a4d554348204d554348204d554348", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/much_zelon_husk_c40ea75281.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

