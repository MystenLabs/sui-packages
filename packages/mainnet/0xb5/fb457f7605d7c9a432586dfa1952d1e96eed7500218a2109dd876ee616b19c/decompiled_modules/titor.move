module 0xb5fb457f7605d7c9a432586dfa1952d1e96eed7500218a2109dd876ee616b19c::titor {
    struct TITOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITOR>(arg0, 6, b"TITOR", b"Jhon Titor", b"Although there is debate over the exact date it started, on November 02, 2000, a person calling themselves Timetravel_0, and later John Titor, started posting on a public forum that he was a time traveler from the year 2036.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_J2_Hsj_W4_400x400_71c12b6502.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

