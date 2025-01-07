module 0x4bfae25e3fdb80c7039bc84c0f770a8699b61470c2b94c2dd786ef2c366a1c4::bitm {
    struct BITM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITM>(arg0, 6, b"Bitm", b"Bitmeme", b"A token related to bitcoin and sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_a9ed3dabee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITM>>(v1);
    }

    // decompiled from Move bytecode v6
}

