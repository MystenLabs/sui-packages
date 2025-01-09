module 0xc7518afb68861a42d6438e1b2f2b6433920c1143c23241b620b0f609f5fb32ca::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"Pawtato AI", b"Building and developing tools with AI for the SUI ecosystem.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PT_AI_4ee1ca4736.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

