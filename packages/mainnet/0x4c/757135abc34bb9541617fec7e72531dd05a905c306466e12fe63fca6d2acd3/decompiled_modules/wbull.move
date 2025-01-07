module 0x4c757135abc34bb9541617fec7e72531dd05a905c306466e12fe63fca6d2acd3::wbull {
    struct WBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBULL>(arg0, 6, b"WBULL", b"WHALEBULL", b"we are starting the biggest bullrun in history, if you cant be rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snapedit_1727778953289_459753b083.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

