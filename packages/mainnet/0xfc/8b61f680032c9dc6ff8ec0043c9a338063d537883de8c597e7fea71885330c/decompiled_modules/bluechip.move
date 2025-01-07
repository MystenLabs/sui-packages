module 0xfc8b61f680032c9dc6ff8ec0043c9a338063d537883de8c597e7fea71885330c::bluechip {
    struct BLUECHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECHIP>(arg0, 6, b"BlueChip", b"Blue", b"A blue potato mfer stands alone as the sole blue-chip memecoin on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240723142952_076c980bdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

