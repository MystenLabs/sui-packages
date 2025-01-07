module 0x94faa842d1a39fd771ed80b060e5490048488b4b12385716860ba3e20534aedf::pdiddy {
    struct PDIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDIDDY>(arg0, 6, b"PDIDDY", b"Puff Daddy", b"Why he diddy what he diddy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_9c90dae132.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

