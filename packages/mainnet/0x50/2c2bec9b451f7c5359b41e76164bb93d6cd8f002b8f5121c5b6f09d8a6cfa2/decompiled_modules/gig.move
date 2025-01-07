module 0x502c2bec9b451f7c5359b41e76164bb93d6cd8f002b8f5121c5b6f09d8a6cfa2::gig {
    struct GIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIG>(arg0, 6, b"GIG", b"GreyisGay", b"Grey is Gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1514_35badaa129.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

