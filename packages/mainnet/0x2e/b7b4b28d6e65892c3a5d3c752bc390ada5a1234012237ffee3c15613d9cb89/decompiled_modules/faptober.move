module 0x2eb7b4b28d6e65892c3a5d3c752bc390ada5a1234012237ffee3c15613d9cb89::faptober {
    struct FAPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAPTOBER>(arg0, 6, b"FAPTOBER", b"Faptober", b"It's that month of the year when we get ready before NNN (No Nut November)!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/memecoin_eddc4c767c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

