module 0x6e67afffb3cf9264e114574b53d34a98a396533145c18512701983b0b165b32e::snif {
    struct SNIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIF>(arg0, 6, b"SNIF", b"SNIF.EXE", b"snif the sniffing dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4354_d40619ebc4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

