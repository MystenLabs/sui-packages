module 0x1b745854092ba1f785763127b125e947e1c293ee0ed9269067370f82bfdf16ed::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 6, b"SPIKE", b"Spike Wazowski on SUI", b"Is funny twist on Mike Wazowski, reimagining with spiked mohawk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6289377717321319187_c_64a64a1b2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

