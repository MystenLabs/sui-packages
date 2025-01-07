module 0xec9b8cb54870efe46cd9767ca8119540e9599c6546e212327512104e0b116524::typus {
    struct TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYPUS>(arg0, 6, b"TYPUS", b"TypusOnSui", x"5265616c205969656c6420496e667261737472756374757265200a405375696e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tipus_08ac5d3f03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

