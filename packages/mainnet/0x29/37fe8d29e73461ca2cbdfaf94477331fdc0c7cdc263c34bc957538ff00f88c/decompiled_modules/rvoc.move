module 0x2937fe8d29e73461ca2cbdfaf94477331fdc0c7cdc263c34bc957538ff00f88c::rvoc {
    struct RVOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RVOC>(arg0, 9, b"RVOC", b"Ryansveryowncoin", b"Mine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RVOC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVOC>>(v2, @0xb43f1a838123ce75344461d91f48695af7d7ca91bc6da65090760e88683a066b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RVOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

